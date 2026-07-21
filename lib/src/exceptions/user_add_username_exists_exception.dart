class UserAddUsernameExistsException implements Exception {
  String cause;
  UserAddUsernameExistsException(this.cause);
}