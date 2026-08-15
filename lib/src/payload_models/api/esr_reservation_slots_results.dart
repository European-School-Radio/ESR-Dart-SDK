import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRReservationSlotsByDateResults {
  String status = "";
  List<ESRReservationSlot> reservationSlots = [];

  ESRReservationSlotsByDateResults({
    required this.status,
    required this.reservationSlots
  });

  factory ESRReservationSlotsByDateResults.fromJson(Map<String, dynamic> json){
    List<ESRReservationSlot> serializedReservations = [];

    List<dynamic> reservationsList = json['reservation_slots'] as List<dynamic>;;

    serializedReservations = reservationsList
        .map((singleReservation) => ESRReservationSlot.fromJson(singleReservation as Map<String, dynamic>))
        .toList();

    serializedReservations.sort((a, b) {
      int dateComparison = a.slotDate.compareTo(b.slotDate);
      if (dateComparison != 0) {
        return dateComparison;
      }
      return a.timeStart.compareTo(b.timeStart);
    });

    return ESRReservationSlotsByDateResults(
      status: json['status'],
      reservationSlots: serializedReservations
    );
  }
}