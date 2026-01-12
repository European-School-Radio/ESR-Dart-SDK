class SortNotAllowedException implements Exception {
  String cause;
  SortNotAllowedException(this.cause);
}