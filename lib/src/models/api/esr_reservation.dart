import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';
import 'package:intl/intl.dart';

class ESRReservation {
  int id = 0;
  DateTime bookingDate = DateTime.now();
  ESRFrequency frequency;
  int slots = 0;
  bool isRepeated = false;
  bool isLive = false;
  int repeatedTimes = 0;
  bool disabled = false;
  ESRProduction? production;
  ESRWeekday repeatedWeekday;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRReservation({
    required this.id,
    required this.bookingDate,
    required this.frequency,
    required this.slots,
    required this.isRepeated,
    required this.isLive,
    required this.repeatedTimes,
    required this.disabled,
    required this.production,
    required this.repeatedWeekday,
    required this.created,
    required this.updated
  });

  factory ESRReservation.fromJson(Map<String, dynamic> json){
    DateFormat dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
    DateTime utcBookingDate = dateFormat.parse(json["booking_date"]);
    DateTime localBookingDate = DateTime.utc(
      utcBookingDate.year,
      utcBookingDate.month,
      utcBookingDate.day,
      utcBookingDate.hour,
      utcBookingDate.minute,
      utcBookingDate.second,
    ).toLocal();

    return ESRReservation(
        id: json['id'],
        bookingDate: localBookingDate,
        frequency: ESRFrequency.fromJson(json['frequency']),
        slots: json['slots'],
        isRepeated: json['is_repeated'],
        isLive: json['is_live'],
        repeatedTimes: json['repeated_times'],
        disabled: json['disabled'],
        production: IsNumericUtils.isNumeric(json['production'].toString()) ? null : ESRProduction.fromJson(json['production']),
        repeatedWeekday: ESRWeekday.fromJson(json['repeated_weekday']),
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated'])
    );
  }
}