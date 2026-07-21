class UserAddEmailExistsException implements Exception {
  String cause;
  UserAddEmailExistsException(this.cause);
}