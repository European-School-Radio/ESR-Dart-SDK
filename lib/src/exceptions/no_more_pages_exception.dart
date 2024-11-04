class NoMorePagesException implements Exception {
  String cause;
  NoMorePagesException(this.cause);
}