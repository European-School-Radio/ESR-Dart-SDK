class ObjectNotPublicException implements Exception {
  String cause;
  ObjectNotPublicException(this.cause);
}