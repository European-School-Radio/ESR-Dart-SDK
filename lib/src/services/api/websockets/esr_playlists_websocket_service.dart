import 'dart:async';
import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/directions/esr_sorting_directions.dart';
import 'package:esr_dart_sdk/src/enums/sorting/esr_playlist_archives_sorting.dart';
import 'package:esr_dart_sdk/src/enums/sorting/esr_playlist_followers_sorting.dart';
import 'package:esr_dart_sdk/src/enums/sorting/esr_playlist_sorting.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class ESRPlaylistsByUserWebsocketService {
  final sdk = ESRSDK();
  String _baseWebSocketURL = "";
  ESRLang? _language;
  int _pageSize = 1;
  int _page = 1;
  int? _userId;
  bool onlyPublic = true;
  ESRPlaylistSorting _sorting = ESRPlaylistSorting.created;
  ESRSortingDirections _direction = ESRSortingDirections.desc;

  bool _isConnected = false;
  WebSocketChannel? _channel;
  final StreamController<ESRPlaylistsByUserResults> _controller =
  StreamController<ESRPlaylistsByUserResults>.broadcast();

  ESRPlaylistsByUserWebsocketService() {
    if (sdk.env == ESREnvironments.test) {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketTestUrl}/playlists-by-user/";
    } else {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketUrl}/playlists-by-user/";
    }
  }

  void setLanguage(ESRLang language) {
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException(
          "WebSocket is already connected");
    }
    _language = language;
  }

  ESRLang? getLanguage() {
    return _language;
  }

  void setPageSize(int newPageSize) {
    _pageSize = newPageSize;

    if (_isConnected){
      Map<String, String> message = {
        "action": "paginate",
        "page_size": _pageSize.toString()
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  int getPageSize() {
    return _pageSize;
  }

  void setPage(int newPage) {
    _page = newPage;

    if (_isConnected){
      Map<String, String> message = {
        "action": "paginate",
        "page": _page.toString()
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  int getPage() {
    return _page;
  }

  void setUserId(int newUserId){
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException(
          "WebSocket is already connected");
    }

    _userId = newUserId;
  }

  int? getUserId(){
    return _userId;
  }

  void setOnlyPublic(bool newOnlyPublic){
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException(
          "WebSocket is already connected");
    }

    onlyPublic = newOnlyPublic;
  }

  bool getOnlyPublic(){
    return onlyPublic;
  }

  void setSorting(ESRPlaylistSorting newSorting) {
    _sorting = newSorting;

    if (_isConnected){
      Map<String, String> message = {
        "action": "paginate",
        "sort": _sorting.value.toString()
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  ESRPlaylistSorting getSorting(){
    return _sorting;
  }

  void setDirection(ESRSortingDirections newDirection){
    _direction = newDirection;

    if (_isConnected){
      Map<String, String> message = {
        "action": "paginate",
        "direction": _direction.value.toString()
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  ESRSortingDirections getDirection(){
    return _direction;
  }

  void connect() {
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException("WebSocket is already connected");
    }

    final urlBuilder = UrlBuilder(_baseWebSocketURL);
    urlBuilder.addQueryParam("lang", (_language == null) ? "en" : _language!.flag);
    urlBuilder.addQueryParam("page_size", _pageSize.toString());
    urlBuilder.addQueryParam("page", _page.toString());
    urlBuilder.addQueryParam("sort", _sorting.value.toString());
    urlBuilder.addQueryParam("direction", _direction.value.toString());
    urlBuilder.addQueryParam("only_public", (onlyPublic) ? "1" : "0");

    if (_userId != null){
      urlBuilder.addQueryParam("user_id", _userId.toString());
    }

    _channel = WebSocketChannel.connect(Uri.parse(urlBuilder.build()));
    _isConnected = true;
    _channel?.stream.listen(
          (message) {
        Map<String, dynamic> jsonMessage = jsonDecode(message);
        _controller.add(ESRPlaylistsByUserResults.fromJson(jsonMessage));
      },
      onError: (error) {
        _isConnected = false;
        disconnect();
      },
      onDone: () {
        _isConnected = false;
      },
    );
  }

  Stream<ESRPlaylistsByUserResults> get stream => _controller.stream;

  StreamSubscription<ESRPlaylistsByUserResults> addListener(
      void Function(ESRPlaylistsByUserResults event) onData,
      {Function? onError,
        void Function()? onDone,
        bool? cancelOnError}) {
    return _controller.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  void sendJson(Map<String, dynamic> message) {
    if (!_isConnected) {
      throw WebsocketNotConnectedException("WebSocket is NOT connected");
    }

    String jsonMessage = jsonEncode(message);

    _channel?.sink.add(jsonMessage);
  }

  void disconnect() {
    if (!_isConnected){
      return;
    }

    _isConnected = false;

    _channel?.sink.close(status.normalClosure);
    _channel = null;

    if (!_controller.isClosed) {
      _controller.close();
    }
  }
}

class ESRPlaylistsSharesCounterWebsocketService {
  final sdk = ESRSDK();
  String _baseWebSocketURL = "";
  int? _playlistId;

  bool _isConnected = false;
  WebSocketChannel? _channel;
  final StreamController<ESRPlaylistsSharesCounterByPlaylistResults> _controller =
  StreamController<ESRPlaylistsSharesCounterByPlaylistResults>.broadcast();

  ESRPlaylistsSharesCounterWebsocketService() {
    if (sdk.env == ESREnvironments.test) {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketTestUrl}/playlists-share/";
    } else {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketUrl}/playlists-share/";
    }
  }

  void setPlaylistId(int newPlaylistId){
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException(
          "WebSocket is already connected");
    }

    _playlistId = newPlaylistId;
  }

  int? getPlaylistId(){
    return _playlistId;
  }

  void connect() {
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException("WebSocket is already connected");
    }

    final urlBuilder = UrlBuilder(_baseWebSocketURL);
    urlBuilder.addQueryParam("playlist_id", _playlistId.toString());

    _channel = WebSocketChannel.connect(Uri.parse(urlBuilder.build()));
    _isConnected = true;
    _channel?.stream.listen(
          (message) {
        Map<String, dynamic> jsonMessage = jsonDecode(message);
        _controller.add(ESRPlaylistsSharesCounterByPlaylistResults.fromJson(jsonMessage));
      },
      onError: (error) {
        _isConnected = false;
        disconnect();
      },
      onDone: () {
        _isConnected = false;
      },
    );
  }

  Stream<ESRPlaylistsSharesCounterByPlaylistResults> get stream => _controller.stream;

  StreamSubscription<ESRPlaylistsSharesCounterByPlaylistResults> addListener(
      void Function(ESRPlaylistsSharesCounterByPlaylistResults event) onData,
      {Function? onError,
        void Function()? onDone,
        bool? cancelOnError}) {
    return _controller.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  void disconnect() {
    if (!_isConnected){
      return;
    }

    _isConnected = false;

    _channel?.sink.close(status.normalClosure);
    _channel = null;

    if (!_controller.isClosed) {
      _controller.close();
    }
  }
}

class ESRPlaylistsFollowersWebsocketService {
  final sdk = ESRSDK();
  String _baseWebSocketURL = "";
  ESRLang? _language;
  int _pageSize = 1;
  int _page = 1;
  int? _playlistId;

  ESRPlaylistFollowersSorting _sorting = ESRPlaylistFollowersSorting.created;
  ESRSortingDirections _direction = ESRSortingDirections.desc;

  bool _isConnected = false;
  WebSocketChannel? _channel;
  final StreamController<ESRPlaylistsFollowersByPlaylistResults> _controller =
  StreamController<ESRPlaylistsFollowersByPlaylistResults>.broadcast();

  ESRPlaylistsFollowersWebsocketService() {
    if (sdk.env == ESREnvironments.test) {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketTestUrl}/follow-playlists-by-playlist/";
    } else {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketUrl}/follow-playlists-by-playlist/";
    }
  }

  void setLanguage(ESRLang language) {
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException("WebSocket is already connected");
    }
    _language = language;
  }

  ESRLang? getLanguage() {
    return _language;
  }

  void setPageSize(int newMaxItems) {
    _pageSize = newMaxItems;

    if (_isConnected){
      Map<String, String> message = {
        "action": "paginate",
        "page_size": _pageSize.toString()
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  int getPageSize() {
    return _pageSize;
  }

  void setPage(int newPage) {
    _page = newPage;

    if (_isConnected){
      Map<String, String> message = {
        "action": "paginate",
        "page": _page.toString()
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  int getPage() {
    return _page;
  }

  void setPlaylistId(int newPlaylistId){
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException(
          "WebSocket is already connected");
    }

    _playlistId = newPlaylistId;
  }

  int? getPlaylistId(){
    return _playlistId;
  }

  void setSorting(ESRPlaylistFollowersSorting newSorting) {
    _sorting = newSorting;

    if (_isConnected){
      Map<String, String> message = {
        "action": "paginate",
        "sort": _sorting.value.toString()
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  ESRPlaylistFollowersSorting getSorting(){
    return _sorting;
  }

  void setDirection(ESRSortingDirections newDirection){
    _direction = newDirection;

    if (_isConnected){
      Map<String, String> message = {
        "action": "paginate",
        "direction": _direction.value.toString()
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  ESRSortingDirections getDirection(){
    return _direction;
  }

  void connect() {
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException("WebSocket is already connected");
    }

    final urlBuilder = UrlBuilder(_baseWebSocketURL);
    urlBuilder.addQueryParam("lang", (_language == null) ? "en" : _language!.flag);
    urlBuilder.addQueryParam("page_size", _pageSize.toString());
    urlBuilder.addQueryParam("page", _page.toString());
    urlBuilder.addQueryParam("playlist_id", _playlistId.toString());
    urlBuilder.addQueryParam("sort", _sorting.value.toString());
    urlBuilder.addQueryParam("direction", _direction.value.toString());

    _channel = WebSocketChannel.connect(Uri.parse(urlBuilder.build()));
    _isConnected = true;
    _channel?.stream.listen(
          (message) {
        Map<String, dynamic> jsonMessage = jsonDecode(message);
        _controller.add(ESRPlaylistsFollowersByPlaylistResults.fromJson(jsonMessage));
      },
      onError: (error) {
        _isConnected = false;
        disconnect();
      },
      onDone: () {
        _isConnected = false;
      },
    );
  }

  Stream<ESRPlaylistsFollowersByPlaylistResults> get stream => _controller.stream;

  StreamSubscription<ESRPlaylistsFollowersByPlaylistResults> addListener(
      void Function(ESRPlaylistsFollowersByPlaylistResults event) onData,
      {Function? onError,
        void Function()? onDone,
        bool? cancelOnError}) {
    return _controller.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  void disconnect() {
    if (!_isConnected){
      return;
    }

    _isConnected = false;

    _channel?.sink.close(status.normalClosure);
    _channel = null;

    if (!_controller.isClosed) {
      _controller.close();
    }
  }
}

class ESRPlaylistsLikesCounterWebsocketService {
  final sdk = ESRSDK();
  String _baseWebSocketURL = "";
  ESRLang? _language;
  int _pageSize = 1;
  int _page = 1;
  int? _playlistId;

  bool _isConnected = false;
  WebSocketChannel? _channel;
  final StreamController<ESRPlaylistsLikesCounterByPlaylistResults> _controller =
  StreamController<ESRPlaylistsLikesCounterByPlaylistResults>.broadcast();

  ESRPlaylistsLikesCounterWebsocketService() {
    if (sdk.env == ESREnvironments.test) {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketTestUrl}/like-playlists-by-playlist/";
    } else {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketUrl}/like-playlists-by-playlist/";
    }
  }

  void setLanguage(ESRLang language) {
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException("WebSocket is already connected");
    }
    _language = language;
  }

  ESRLang? getLanguage() {
    return _language;
  }

  void setPageSize(int newMaxItems) {
    _pageSize = newMaxItems;

    if (_isConnected){
      Map<String, String> message = {
        "action": "paginate",
        "page_size": _pageSize.toString()
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  int getPageSize() {
    return _pageSize;
  }

  void setPage(int newPage) {
    _page = newPage;

    if (_isConnected){
      Map<String, String> message = {
        "action": "paginate",
        "page": _page.toString()
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  int getPage() {
    return _page;
  }

  void setPlaylistId(int newPlaylistId){
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException(
          "WebSocket is already connected");
    }

    _playlistId = newPlaylistId;
  }

  int? getPlaylistId(){
    return _playlistId;
  }

  void connect() {
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException("WebSocket is already connected");
    }

    final urlBuilder = UrlBuilder(_baseWebSocketURL);
    urlBuilder.addQueryParam("lang", (_language == null) ? "en" : _language!.flag);
    urlBuilder.addQueryParam("page_size", _pageSize.toString());
    urlBuilder.addQueryParam("page", _page.toString());
    urlBuilder.addQueryParam("playlist_id", _playlistId.toString());

    _channel = WebSocketChannel.connect(Uri.parse(urlBuilder.build()));
    _isConnected = true;
    _channel?.stream.listen(
          (message) {
        Map<String, dynamic> jsonMessage = jsonDecode(message);
        _controller.add(ESRPlaylistsLikesCounterByPlaylistResults.fromJson(jsonMessage));
      },
      onError: (error) {
        _isConnected = false;
        disconnect();
      },
      onDone: () {
        _isConnected = false;
      },
    );
  }

  Stream<ESRPlaylistsLikesCounterByPlaylistResults> get stream => _controller.stream;

  StreamSubscription<ESRPlaylistsLikesCounterByPlaylistResults> addListener(
      void Function(ESRPlaylistsLikesCounterByPlaylistResults event) onData,
      {Function? onError,
        void Function()? onDone,
        bool? cancelOnError}) {
    return _controller.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  void disconnect() {
    if (!_isConnected){
      return;
    }

    _isConnected = false;

    _channel?.sink.close(status.normalClosure);
    _channel = null;

    if (!_controller.isClosed) {
      _controller.close();
    }
  }
}

class ESRPlaylistsArchivesByPlaylistWebsocketService {
  final sdk = ESRSDK();
  String _baseWebSocketURL = "";
  ESRLang? _language;
  int _pageSize = 1;
  int _page = 1;
  int? _playlistId;
  bool _onlyPublic = true;
  ESRPlaylistArchivesSorting _sorting = ESRPlaylistArchivesSorting.created;
  ESRSortingDirections _direction = ESRSortingDirections.desc;

  bool _isConnected = false;
  WebSocketChannel? _channel;
  final StreamController<ESRPlaylistsArchivesByPlaylistResults> _controller =
  StreamController<ESRPlaylistsArchivesByPlaylistResults>.broadcast();

  ESRPlaylistsArchivesByPlaylistWebsocketService() {
    if (sdk.env == ESREnvironments.test) {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketTestUrl}/playlist-archives-by-playlist/";
    } else {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketUrl}/playlist-archives-by-playlist/";
    }
  }

  void setLanguage(ESRLang language) {
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException("WebSocket is already connected");
    }
    _language = language;
  }

  ESRLang? getLanguage() {
    return _language;
  }

  void setPageSize(int newMaxItems) {
    _pageSize = newMaxItems;

    if (_isConnected){
      Map<String, String> message = {
        "action": "paginate",
        "page_size": _pageSize.toString()
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  int getPageSize() {
    return _pageSize;
  }

  void setPage(int newPage) {
    _page = newPage;

    if (_isConnected){
      Map<String, String> message = {
        "action": "paginate",
        "page": _page.toString()
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  int getPage() {
    return _page;
  }

  void setPlaylistId(int newPlaylistId){
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException(
          "WebSocket is already connected");
    }

    _playlistId = newPlaylistId;
  }

  int? getPlaylistId(){
    return _playlistId;
  }

  void setOnlyPublic(bool newOnlyPublic){
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException(
          "WebSocket is already connected");
    }

    _onlyPublic = newOnlyPublic;
  }

  bool getOnlyPublic(){
    return _onlyPublic;
  }

  void setSorting(ESRPlaylistArchivesSorting newSorting) {
    _sorting = newSorting;

    if (_isConnected){
      Map<String, String> message = {
        "action": "paginate",
        "sort": _sorting.value.toString()
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  ESRPlaylistArchivesSorting getSorting(){
    return _sorting;
  }

  void setDirection(ESRSortingDirections newDirection){
    _direction = newDirection;

    if (_isConnected){
      Map<String, String> message = {
        "action": "paginate",
        "direction": _direction.value.toString()
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  ESRSortingDirections getDirection(){
    return _direction;
  }

  void connect() {
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException("WebSocket is already connected");
    }

    final urlBuilder = UrlBuilder(_baseWebSocketURL);
    urlBuilder.addQueryParam("lang", (_language == null) ? "en" : _language!.flag);
    urlBuilder.addQueryParam("page_size", _pageSize.toString());
    urlBuilder.addQueryParam("page", _page.toString());
    urlBuilder.addQueryParam("playlist_id", _playlistId.toString());
    urlBuilder.addQueryParam("only_public", (_onlyPublic) ? "1" : "0");
    urlBuilder.addQueryParam("sort", _sorting.value.toString());
    urlBuilder.addQueryParam("direction", _direction.value.toString());

    _channel = WebSocketChannel.connect(Uri.parse(urlBuilder.build()));
    _isConnected = true;
    _channel?.stream.listen(
          (message) {
        Map<String, dynamic> jsonMessage = jsonDecode(message);
        _controller.add(ESRPlaylistsArchivesByPlaylistResults.fromJson(jsonMessage));
      },
      onError: (error) {
        _isConnected = false;
        disconnect();
      },
      onDone: () {
        _isConnected = false;
      },
    );
  }

  Stream<ESRPlaylistsArchivesByPlaylistResults> get stream => _controller.stream;

  StreamSubscription<ESRPlaylistsArchivesByPlaylistResults> addListener(
      void Function(ESRPlaylistsArchivesByPlaylistResults event) onData,
      {Function? onError,
        void Function()? onDone,
        bool? cancelOnError}) {
    return _controller.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  void disconnect() {
    if (!_isConnected){
      return;
    }

    _isConnected = false;

    _channel?.sink.close(status.normalClosure);
    _channel = null;

    if (!_controller.isClosed) {
      _controller.close();
    }
  }
}