import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRProductionSubjectAddResult {
  String status;
  String message;
  ESRProductionSubject productionSubject;

  ESRProductionSubjectAddResult({
    required this.status,
    required this.message,
    required this.productionSubject
  });
  
  factory ESRProductionSubjectAddResult.fromJson(Map<String, dynamic> json){
    return ESRProductionSubjectAddResult(
      status: json["status"],
      message: json["message"],
        productionSubject: ESRProductionSubject.fromJson(json["production_subject"])
    );
  }
}