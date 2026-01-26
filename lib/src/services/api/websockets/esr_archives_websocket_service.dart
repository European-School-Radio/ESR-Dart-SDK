import 'dart:async';
import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/directions/esr_sorting_directions.dart';
import 'package:esr_dart_sdk/src/enums/sorting/esr_archive_sorting.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class ESRArchivesSearchWebsocketService {
  final sdk = ESRSDK();
  String _baseWebSocketURL = "";
  ESRLang? _language;
  int _pageSize = 1;
  int? _userId;
  bool _showSchedulable = false;
  bool _showPodcast = false;
  bool _showSpecial = false;
  ESRArchiveSorting _sorting = ESRArchiveSorting.created;
  ESRSortingDirections _direction = ESRSortingDirections.desc;

  bool _isConnected = false;
  WebSocketChannel? _channel;
  final StreamController<ESRArchivesWebsocketListResults> _controller =
  StreamController<ESRArchivesWebsocketListResults>.broadcast();

  ESRArchivesSearchWebsocketService() {
    if (sdk.env == ESREnvironments.test) {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketTestUrl}/archives-search/";
    } else {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketUrl}/archives-search/";
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

  void setSorting(ESRArchiveSorting newSorting) {
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

  ESRArchiveSorting getSorting(){
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

  void setShowSchedulable(bool newShowSchedulable){
    _showSchedulable = newShowSchedulable;

    if (_isConnected){
      Map<String, String> message = {
        "action": "paginate",
        "show_schedulable": (_showSchedulable) ? "1" : "0"
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  bool getShowSchedulable(){
    return _showSchedulable;
  }

  void setShowPodcast(bool newShowPodcast){
    _showPodcast = newShowPodcast;

    if (_isConnected){
      Map<String, String> message = {
        "action": "paginate",
        "show_podcasts": (_showPodcast) ? "1" : "0"
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  bool getShowPodcast(){
    return _showPodcast;
  }

  void setShowSpecial(bool newShowSpecial){
    _showSpecial = newShowSpecial;

    if (_isConnected){
      Map<String, String> message = {
        "action": "paginate",
        "show_special": (_showSpecial) ? "1" : "0"
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }
  
  bool getShowSpecial(){
    return _showSpecial;
  }

  void connect() {
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException("WebSocket is already connected");
    }

    final urlBuilder = UrlBuilder(_baseWebSocketURL);
    urlBuilder.addQueryParam("lang", (_language == null) ? "en" : _language!.flag);
    urlBuilder.addQueryParam("page_size", _pageSize.toString());
    urlBuilder.addQueryParam("show_schedulable", (_showSchedulable) ? "1" : "0");
    urlBuilder.addQueryParam("show_podcasts", (_showPodcast) ? "1" : "0");
    urlBuilder.addQueryParam("show_special", (_showSpecial) ? "1" : "0");
    urlBuilder.addQueryParam("sort", _sorting.value.toString());
    urlBuilder.addQueryParam("direction", _direction.value.toString());

    if (_userId != null){
      urlBuilder.addQueryParam("user_id", _userId.toString());
    }

    _channel = WebSocketChannel.connect(Uri.parse(urlBuilder.build()));
    _isConnected = true;
    _channel?.stream.listen(
          (message) {
        Map<String, dynamic> jsonMessage = jsonDecode(message);
        _controller.add(ESRArchivesWebsocketListResults.fromJson(jsonMessage, _pageSize));
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

  Stream<ESRArchivesWebsocketListResults> get stream => _controller.stream;

  StreamSubscription<ESRArchivesWebsocketListResults> addListener(
      void Function(ESRArchivesWebsocketListResults event) onData,
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

class ESRArchivesSharesCounterWebsocketService {
  final sdk = ESRSDK();
  String _baseWebSocketURL = "";
  ESRLang? _language;
  int _pageSize = 1;
  int? _archiveId;

  bool _isConnected = false;
  WebSocketChannel? _channel;
  final StreamController<ESRArchivesSharesCounterByArchiveResults> _controller =
  StreamController<ESRArchivesSharesCounterByArchiveResults>.broadcast();

  ESRArchivesSharesCounterWebsocketService() {
    if (sdk.env == ESREnvironments.test) {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketTestUrl}/archive-shares-count-by-archive/";
    } else {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketUrl}/archive-shares-count-by-archive/";
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

  void setArchiveId(int newArchiveId){
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException(
          "WebSocket is already connected");
    }

    _archiveId = newArchiveId;
  }

  int? getArchiveId(){
    return _archiveId;
  }

  void connect() {
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException("WebSocket is already connected");
    }

    final urlBuilder = UrlBuilder(_baseWebSocketURL);
    urlBuilder.addQueryParam("lang", (_language == null) ? "en" : _language!.flag);
    urlBuilder.addQueryParam("page_size", _pageSize.toString());
    urlBuilder.addQueryParam("archive_id", _archiveId.toString());

    _channel = WebSocketChannel.connect(Uri.parse(urlBuilder.build()));
    _isConnected = true;
    _channel?.stream.listen(
          (message) {
        Map<String, dynamic> jsonMessage = jsonDecode(message);
        _controller.add(ESRArchivesSharesCounterByArchiveResults.fromJson(jsonMessage));
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

  Stream<ESRArchivesSharesCounterByArchiveResults> get stream => _controller.stream;

  StreamSubscription<ESRArchivesSharesCounterByArchiveResults> addListener(
      void Function(ESRArchivesSharesCounterByArchiveResults event) onData,
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