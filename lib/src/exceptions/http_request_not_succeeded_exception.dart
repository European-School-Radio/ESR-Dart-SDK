class HttpRequestNotSucceededException implements Exception {
  String cause;
  HttpRequestNotSucceededException(this.cause);
}