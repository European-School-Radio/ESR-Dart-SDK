import 'package:intl/intl.dart';

class ESRDateTimeFormatter {
  static String formatDateTimeRequests(DateTime datetime){
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime);
  }

  static String formatDateRequests(DateTime datetime){
    return DateFormat("yyyy-MM-dd").format(datetime);
  }

  static String formatTimeRequests(DateTime datetime){
    return DateFormat("HH:mm:ss").format(datetime);
  }

  static String formatMinimalTimeRequests(DateTime datetime){
    return DateFormat("HH:mm").format(datetime);
  }
}