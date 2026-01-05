class ESRReservationsMinMaxDatesResults {
  DateTime minDate;
  DateTime maxDate;

  ESRReservationsMinMaxDatesResults({
    required this.minDate,
    required this.maxDate
  });

  factory ESRReservationsMinMaxDatesResults.fromJson(Map<String, dynamic> json){
    return ESRReservationsMinMaxDatesResults(
        minDate: DateTime.parse(json['min_date']),
        maxDate: DateTime.parse(json['max_date'])
    );
  }
}