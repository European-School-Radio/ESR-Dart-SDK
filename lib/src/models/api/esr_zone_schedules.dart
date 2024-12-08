import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';
import 'package:intl/intl.dart';

class ESRZoneSchedules {
  int id = 0;
  DateTime timeFrom;
  DateTime timeTo;
  ESRZone? zone;
  ESRWeekday weekday;
  DateTime created;
  DateTime updated;

  ESRZoneSchedules({
    required this.id,
    required this.timeFrom,
    required this.timeTo,
    required this.zone,
    required this.weekday,
    required this.created,
    required this.updated
  });

  factory ESRZoneSchedules.fromJson(Map<String, dynamic> json){
    DateFormat format = DateFormat("HH:mm:ss");
    DateTime utcTimeFrom = format.parse(json['time_from']);
    DateTime localTimeFrom = DateTime.utc(
      utcTimeFrom.year,
      utcTimeFrom.month,
      utcTimeFrom.day,
      utcTimeFrom.hour,
      utcTimeFrom.minute,
      utcTimeFrom.second,
    ).toLocal();

    DateTime utcTimeTo = format.parse(json["time_to"]);
    DateTime localTimeTo = DateTime.utc(
      utcTimeTo.year,
      utcTimeTo.month,
      utcTimeTo.day,
      utcTimeTo.hour,
      utcTimeTo.minute,
      utcTimeTo.second,
    ).toLocal();

    return ESRZoneSchedules(
      id: json["id"],
      timeFrom: localTimeFrom,
      timeTo: localTimeTo,
      zone: IsNumericUtils.isNumeric(json["zone"].toString()) ? null : ESRZone.fromJson(json["zone"]),
      weekday: ESRWeekday.fromJson(json["weekday"]),
      created: DateTime.parse(json["created"]),
      updated: DateTime.parse(json["updated"])
    );
  }
}