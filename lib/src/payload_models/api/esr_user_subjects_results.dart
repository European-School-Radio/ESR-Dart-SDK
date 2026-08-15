import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRUserSubjectAddResults {
  String status = "";
  String message = "";
  ESRUserSubject? userSubject;

  ESRUserSubjectAddResults({
    required this.status,
    required this.message,
    required this.userSubject
  });
  
  factory ESRUserSubjectAddResults.fromJson(Map<String, dynamic> json){
    return ESRUserSubjectAddResults(
      status: json['status'],
      message: json['message'],
      userSubject: ESRUserSubject.fromJson(json['user_subject'])
    );
  }
}