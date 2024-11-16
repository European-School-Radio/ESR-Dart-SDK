import 'dart:async';
import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class ESRJazlerNowPlayingWebsocketService {
  String _baseWebSocketURL = "";

  bool _isConnected = false;
  WebSocketChannel? _channel;
  final StreamController<ESRJazlerNowPlayingResults> _controller =
      StreamController<ESRJazlerNowPlayingResults>.broadcast();

  ESRJazlerNowPlayingWebsocketService() {
    _baseWebSocketURL = "${ESRServerConfig.websocketUrl}/jazler-now-on-air/";
  }

  void connect() {
    if (_isConnected) {
      throw WebsocketAlreadyConnectedException(
          "WebSocket is already connected");
    }

    _channel = WebSocketChannel.connect(Uri.parse(_baseWebSocketURL));
    _isConnected = true;
    _channel?.stream.listen(
      (message) {
        Map<String, dynamic> jsonMessage = jsonDecode(message);
        _controller.add(ESRJazlerNowPlayingResults.fromJson(jsonMessage));
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

  Stream<ESRJazlerNowPlayingResults> get stream => _controller.stream;

  StreamSubscription<ESRJazlerNowPlayingResults> addListener(
      void Function(ESRJazlerNowPlayingResults event) onData,
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
    _channel?.sink.close(status.goingAway);
    _controller.close();
  }
}
