import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRUserSchoolApprovalsAddResults {
  String status = "";
  String message = "";
  ESRUserSchoolApproval? userSchoolApproval;

  ESRUserSchoolApprovalsAddResults({
    required this.status,
    required this.message,
    required this.userSchoolApproval
  });
  
  factory ESRUserSchoolApprovalsAddResults.fromJson(Map<String, dynamic> json){
    return ESRUserSchoolApprovalsAddResults(
      status: json['status'],
      message: json['message'],
      userSchoolApproval: ESRUserSchoolApproval.fromJson(json['user_school_approval'])
    );
  }
}