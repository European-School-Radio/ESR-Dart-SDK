class WebsocketNotConnectedException implements Exception {
  String cause;
  WebsocketNotConnectedException(this.cause);
}