import 'package:intl/intl.dart';

class ESRDateTimeFormatter {
  static String formatDateTimeRequests(DateTime datetime){
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime);
  }
}