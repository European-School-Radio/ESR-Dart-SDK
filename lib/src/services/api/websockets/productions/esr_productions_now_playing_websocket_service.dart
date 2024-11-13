import 'dart:async';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class ESRProductionsNowPlayingWebsocketService {
  String _baseWebSocketURL = "";
  ESRLang? _language;
  int _maxItems = 1;
  WebSocketChannel? _channel;
  final StreamController<String> _controller = StreamController<String>.broadcast();

  ESRProductionsNowPlayingWebsocketService() {
    _baseWebSocketURL = "${ESRServerConfig.websocketUrl}/productions-now-playing/";
  }

  void setLanguage(ESRLang language){
    if (_channel == null){
      throw WebsocketAlreadyConnectedException("WebSocket is already connected");
    }
    _language = language;
  }

  ESRLang? getLanguage(){
    return _language;
  }

  void setMaxItems(int newMaxItems){
    if (_channel == null){
      throw WebsocketAlreadyConnectedException("WebSocket is already connected");
    }
    _maxItems = newMaxItems;
  }

  int getMaxItems(){
    return _maxItems;
  }

  void connect() {
    if (_channel != null){
      throw WebsocketAlreadyConnectedException("WebSocket is already connected");
    }

    final urlBuilder = UrlBuilder(_baseWebSocketURL);
    urlBuilder.addQueryParam("lang", (_language == null) ? "en" : _language!.flag);
    urlBuilder.addQueryParam("max_items", _maxItems.toString());

    _channel = WebSocketChannel.connect(Uri.parse(urlBuilder.build()));
    _channel?.stream.listen(
          (message) {
        _controller.add(message);
      },
      onError: (error) {
        print("WebSocket error: $error");
      },
      onDone: () {
        print("WebSocket connection closed");
      },
    );
  }

  Stream<String> get stream => _controller.stream;

  void sendMessage(String message) {
    if (_channel == null){
      throw WebsocketNotConnectedException("WebSocket is NOT connected");
    }
    _channel?.sink.add(message);
  }

  void disconnect() {
    if (_channel == null){
      throw WebsocketNotConnectedException("WebSocket is NOT connected");
    }

    _channel?.sink.close(status.goingAway);
    _controller.close();
  }
}
