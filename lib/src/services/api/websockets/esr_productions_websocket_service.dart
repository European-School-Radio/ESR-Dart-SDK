import 'dart:async';
import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/directions/esr_sorting_directions.dart';
import 'package:esr_dart_sdk/src/enums/sorting/esr_production_sorting.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class ESRProductionsNextPlayingWebsocketService {
  final sdk = ESRSDK();
  String _baseWebSocketURL = "";
  ESRLang? _language;
  int _maxItems = 1;

  bool _isConnected = false;
  WebSocketChannel? _channel;
  final StreamController<ESRProductionsNextPlayingResults> _controller =
  StreamController<ESRProductionsNextPlayingResults>.broadcast();

  ESRProductionsNextPlayingWebsocketService() {
    if (sdk.env == ESREnvironments.test) {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketTestUrl}/productions-next-playing/";
    } else {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketUrl}/productions-next-playing/";
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

  void setMaxItems(int newMaxItems) {
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException(
          "WebSocket is already connected");
    }
    _maxItems = newMaxItems;
  }

  int getMaxItems() {
    return _maxItems;
  }

  void connect() {
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException(
          "WebSocket is already connected");
    }

    final urlBuilder = UrlBuilder(_baseWebSocketURL);
    urlBuilder.addQueryParam(
        "lang", (_language == null) ? "en" : _language!.flag);
    urlBuilder.addQueryParam("max_items", _maxItems.toString());

    _channel = WebSocketChannel.connect(Uri.parse(urlBuilder.build()));
    _isConnected = true;
    _channel?.stream.listen(
          (message) {
        Map<String, dynamic> jsonMessage = jsonDecode(message);
        _controller.add(ESRProductionsNextPlayingResults.fromJson(jsonMessage));
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

  Stream<ESRProductionsNextPlayingResults> get stream => _controller.stream;

  StreamSubscription<ESRProductionsNextPlayingResults> addListener(
      void Function(ESRProductionsNextPlayingResults event) onData,
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

  void sendMessage(String message) {
    if (!_isConnected) {
      throw WebsocketNotConnectedException("WebSocket is NOT connected");
    }
    _channel?.sink.add(message);
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

class ESRProductionsNowPlayingWebsocketService {
  final sdk = ESRSDK();
  String _baseWebSocketURL = "";
  ESRLang? _language;
  int _maxItems = 1;

  bool _isConnected = false;
  WebSocketChannel? _channel;
  final StreamController<ESRProductionsNowPlayingResults> _controller =
  StreamController<ESRProductionsNowPlayingResults>.broadcast();

  ESRProductionsNowPlayingWebsocketService() {
    if (sdk.env == ESREnvironments.test) {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketTestUrl}/productions-now-playing/";
    } else {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketUrl}/productions-now-playing/";
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

  void setMaxItems(int newMaxItems) {
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException(
          "WebSocket is already connected");
    }
    _maxItems = newMaxItems;
  }

  int getMaxItems() {
    return _maxItems;
  }

  void connect() {
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException(
          "WebSocket is already connected");
    }

    final urlBuilder = UrlBuilder(_baseWebSocketURL);
    urlBuilder.addQueryParam(
        "lang", (_language == null) ? "en" : _language!.flag);
    urlBuilder.addQueryParam("max_items", _maxItems.toString());

    _channel = WebSocketChannel.connect(Uri.parse(urlBuilder.build()));
    _isConnected = true;
    _channel?.stream.listen(
          (message) {
        Map<String, dynamic> jsonMessage = jsonDecode(message);
        _controller.add(ESRProductionsNowPlayingResults.fromJson(jsonMessage));
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

  Stream<ESRProductionsNowPlayingResults> get stream => _controller.stream;

  StreamSubscription<ESRProductionsNowPlayingResults> addListener(
      void Function(ESRProductionsNowPlayingResults event) onData,
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

  void sendMessage(String message) {
    if (!_isConnected) {
      throw WebsocketNotConnectedException("WebSocket is NOT connected");
    }
    _channel?.sink.add(message);
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

class ESRProductionsSearchWebsocketService {
  final sdk = ESRSDK();
  String _baseWebSocketURL = "";
  ESRLang? _language;
  int _pageSize = 1;
  ESRProductionSorting _sorting = ESRProductionSorting.created;
  ESRSortingDirections _direction = ESRSortingDirections.desc;

  bool _isConnected = false;
  WebSocketChannel? _channel;
  final StreamController<ESRProductionsPaginatedResults> _controller =
  StreamController<ESRProductionsPaginatedResults>.broadcast();

  ESRProductionsSearchWebsocketService() {
    if (sdk.env == ESREnvironments.test) {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketTestUrl}/productions-search/";
    } else {
      _baseWebSocketURL =
      "${ESRServerConfig.websocketUrl}/productions-search/";
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
        "page_size": _pageSize.toString()
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  int getPageSize() {
    return _pageSize;
  }

  void setSorting(ESRProductionSorting newSorting) {
    _sorting = newSorting;

    if (_isConnected){
      Map<String, String> message = {
        "sort": _sorting.value.toString()
      };
      String jsonMessage = jsonEncode(message);
      _channel?.sink.add(jsonMessage);
    }
  }

  ESRProductionSorting getSorting(){
    return _sorting;
  }

  void setDirection(ESRSortingDirections newDirection){
    _direction = newDirection;

    if (_isConnected){
      Map<String, String> message = {
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

    _channel = WebSocketChannel.connect(Uri.parse(urlBuilder.build()));
    _isConnected = true;
    _channel?.stream.listen(
          (message) {
        Map<String, dynamic> jsonMessage = jsonDecode(message);
        _controller.add(ESRProductionsPaginatedResults.fromJson(jsonMessage, _pageSize));
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

  Stream<ESRProductionsPaginatedResults> get stream => _controller.stream;

  StreamSubscription<ESRProductionsPaginatedResults> addListener(
      void Function(ESRProductionsPaginatedResults event) onData,
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