class WebsocketAlreadyConnectedException implements Exception {
  String cause;
  WebsocketAlreadyConnectedException(this.cause);
}