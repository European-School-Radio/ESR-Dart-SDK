import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRSSOLoginTriesAddResult {
  String status = "";
  String message = "";
  ESRSSOLoginTry? ssoLoginTry;

  ESRSSOLoginTriesAddResult({
    required this.status,
    required this.message,
    required this.ssoLoginTry
  });
  
  factory ESRSSOLoginTriesAddResult.fromJson(Map<String, dynamic> json){
    return ESRSSOLoginTriesAddResult(
      status: json['status'],
      message: json['message'],
      ssoLoginTry: ESRSSOLoginTry.fromJson(json)
    );
  }
}