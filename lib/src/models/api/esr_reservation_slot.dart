import 'package:esr_dart_sdk/esr_dart_sdk.dart';

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
    return ESRReservationSlot(
      id: (json["id"] == null) ? 0 : json["id"],
      slotDate: DateTime.parse(json['slot_date'] + " 00:00:00").toLocal(),
      timeStart: DateTime.parse("1970-01-01 " + json["time_start"]).toLocal(),
      timeEnd: DateTime.parse("1970-01-01 " + json["time_end"]).toLocal(),
      reservation: ESRReservation.fromJson(json['reservation']),
      created: (json['created'] == null) ? DateTime.now() : DateTime.parse(json['created']).toLocal(),
      updated: (json['updated'] == null) ? DateTime.now() : DateTime.parse(json['updated']).toLocal()
    );
  }
}