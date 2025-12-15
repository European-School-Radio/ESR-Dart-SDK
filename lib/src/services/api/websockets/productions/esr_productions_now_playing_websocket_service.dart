import 'dart:async';
import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

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
        disconnect();
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
    if (!_isConnected) {
      throw WebsocketNotConnectedException("WebSocket is NOT connected");
    }

    _isConnected = false;
    _channel?.sink.close(status.normalClosure);
    _controller.close();
  }
}
