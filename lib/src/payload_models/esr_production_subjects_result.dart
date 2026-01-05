import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRProductionSubjectsAddResult {
  String status;
  String message;
  ESRProductionSubject productionSubject;

  ESRProductionSubjectsAddResult({
    required this.status,
    required this.message,
    required this.productionSubject
  });
  
  factory ESRProductionSubjectsAddResult.fromJson(Map<String, dynamic> json){
    return ESRProductionSubjectsAddResult(
      status: json["status"],
      message: json["message"],
        productionSubject: ESRProductionSubject.fromJson(json["production_subject"])
    );
  }
}