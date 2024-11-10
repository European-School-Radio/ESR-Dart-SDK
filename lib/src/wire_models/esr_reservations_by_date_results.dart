import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRReservationsByDateResults {
  List<ESRReservation> reservations = [];

  ESRReservationsByDateResults({
    required this.reservations
  });

  factory ESRReservationsByDateResults.fromJson(Map<String, dynamic> json){
    List<ESRReservation> serializedReservations = [];

    List<dynamic> reservationsList = json['reservations'] as List<dynamic>;;

    serializedReservations = reservationsList
        .map((singleReservation) => ESRReservation.fromJson(singleReservation as Map<String, dynamic>))
        .toList();

    return ESRReservationsByDateResults(
      reservations: serializedReservations
    );
  }
}