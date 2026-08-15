import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRGeolocationCountryResults {
  String status = "";
  ESRCountry? countryDetails;

  ESRGeolocationCountryResults({
    required this.status,
    required this.countryDetails
  });
  
  factory ESRGeolocationCountryResults.fromJson(Map<String, dynamic> json){
    return ESRGeolocationCountryResults(
      status: json['status'],
      countryDetails: ESRCountry.fromJson(json['country_details'])
    );
  }
}

class ESRGeolocationTimezoneResults {
  String status = "";
  String timezone = "";

  ESRGeolocationTimezoneResults({
    required this.status,
    required this.timezone
  });

  factory ESRGeolocationTimezoneResults.fromJson(Map<String, dynamic> json){
    return ESRGeolocationTimezoneResults(
      status: json['status'],
      timezone: json['timezone']
    );
  }
}

class ESRGeolocationCoordinatesResults {
  String status = "";
  double latitude = 0.0;
  double longitude = 0.0;

  ESRGeolocationCoordinatesResults({
    required this.status,
    required this.latitude,
    required this.longitude
  });

  factory ESRGeolocationCoordinatesResults.fromJson(Map<String, dynamic> json){
    return ESRGeolocationCoordinatesResults(
      status: json['status'],
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude'])
    );
  }
}