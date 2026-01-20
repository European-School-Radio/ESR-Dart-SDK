import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:intl/intl.dart';

class ESRReservationSlot {
  int id = 0;
  DateTime slotDate = DateTime.now();
  DateTime timeStart = DateTime.now();
  DateTime timeEnd = DateTime.now();
  bool hasArchive = false;
  ESRReservation reservation;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRReservationSlot({
    required this.id,
    required this.slotDate,
    required this.timeStart,
    required this.timeEnd,
    required this.hasArchive,
    required this.reservation,
    required this.created,
    required this.updated
  });
  
  factory ESRReservationSlot.fromJson(Map<String, dynamic> json){
    DateFormat timeFormat = DateFormat("HH:mm:ss");
    DateTime utcTimeStart = timeFormat.parse(json['time_start']);
    DateTime localTimeStart = DateTime.utc(
      utcTimeStart.year,
      utcTimeStart.month,
      utcTimeStart.day,
      utcTimeStart.hour,
      utcTimeStart.minute,
      utcTimeStart.second,
    ).toLocal();

    DateTime utcTimeEnd = timeFormat.parse(json['time_end']);
    DateTime localTimeEnd = DateTime.utc(
      utcTimeEnd.year,
      utcTimeEnd.month,
      utcTimeEnd.day,
      utcTimeEnd.hour,
      utcTimeEnd.minute,
      utcTimeEnd.second,
    ).toLocal();

    DateFormat dateFormat = DateFormat("yyyy-mm-dd");
    DateTime utcSlotDate = dateFormat.parse(json["slot_date"]);
    DateTime localSlotDate = DateTime.utc(
      utcSlotDate.year,
      utcSlotDate.month,
      utcSlotDate.day,
      utcSlotDate.hour,
      utcSlotDate.minute,
      utcSlotDate.second,
    ).toLocal();

    return ESRReservationSlot(
      id: (json["id"] == null) ? 0 : json["id"],
      slotDate: localSlotDate,
      timeStart: localTimeStart,
      timeEnd: localTimeEnd,
      hasArchive: json['has_archive'],
      reservation: ESRReservation.fromJson(json['reservation']),
      created: (json['created'] == null) ? DateTime.now() : DateTime.parse(json['created']),
      updated: (json['updated'] == null) ? DateTime.now() : DateTime.parse(json['updated'])
    );
  }
}