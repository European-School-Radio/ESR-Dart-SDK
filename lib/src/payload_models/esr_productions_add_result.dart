import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRProductionsAddResults {
  String status;
  String message;
  ESRProduction production;

  ESRProductionsAddResults({
    required this.status,
    required this.message,
    required this.production
  });
  
  factory ESRProductionsAddResults.fromJson(Map<String, dynamic> json){
    return ESRProductionsAddResults(
      status: json["status"],
      message: json["message"],
      production: ESRProduction.fromJson(json["production"])
    );
  }
}