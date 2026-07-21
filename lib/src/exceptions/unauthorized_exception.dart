class UnAuthorizedException implements Exception {
  String cause;
  UnAuthorizedException(this.cause);
}