import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:intl/intl.dart';

class ESRReservationSlot {
  int id = 0;
  DateTime slotDate = DateTime.now();
  DateTime timeStart = DateTime.now();
  DateTime timeEnd = DateTime.now();
  ESRReservation reservation;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRReservationSlot({
    required this.id,
    required this.slotDate,
    required this.timeStart,
    required this.timeEnd,
    required this.reservation,
    required this.created,
    required this.updated
  });
  
  factory ESRReservationSlot.fromJson(Map<String, dynamic> json){
    DateFormat dateFormat = DateFormat("HH:mm:ss");
    DateTime utcTimeStart = dateFormat.parse(json['time_start']);
    DateTime localTimeStart = DateTime.utc(
      utcTimeStart.year,
      utcTimeStart.month,
      utcTimeStart.day,
      utcTimeStart.hour,
      utcTimeStart.minute,
      utcTimeStart.second,
    ).toLocal();

    DateTime utcTimeEnd = dateFormat.parse(json['time_end']);
    DateTime localTimeEnd = DateTime.utc(
      utcTimeEnd.year,
      utcTimeEnd.month,
      utcTimeEnd.day,
      utcTimeEnd.hour,
      utcTimeEnd.minute,
      utcTimeEnd.second,
    ).toLocal();

    return ESRReservationSlot(
      id: (json["id"] == null) ? 0 : json["id"],
      slotDate: DateTime.parse(json['slot_date'] + " 00:00:00").toLocal(),
      timeStart: localTimeStart,
      timeEnd: localTimeEnd,
      reservation: ESRReservation.fromJson(json['reservation']),
      created: (json['created'] == null) ? DateTime.now() : DateTime.parse(json['created']),
      updated: (json['updated'] == null) ? DateTime.now() : DateTime.parse(json['updated'])
    );
  }
}