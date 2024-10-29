class IsNumericUtils {
  static bool isNumeric(String s) {
    try {
      double.parse(s);
      return true;
    } on FormatException {
      return false;
    }
  }
}