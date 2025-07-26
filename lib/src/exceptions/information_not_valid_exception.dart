class InformationNotValidException implements Exception {
  String cause;
  InformationNotValidException(this.cause);
}