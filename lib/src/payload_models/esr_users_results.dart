import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRUsersLoginResults {
  bool success;
  String status;
  String message;
  ESRUserJwtData? jwtData;

  ESRUsersLoginResults(
      {required this.success,
      required this.status,
      required this.message,
      this.jwtData});

  factory ESRUsersLoginResults.fromJson(Map<String, dynamic> json) {
    return ESRUsersLoginResults(
        success: (json["status"] == "success"),
        status: json["status"],
        message: json["message"],
        jwtData: (json.containsKey("jwt_data") && json["jwt_data"] != null)
            ? ESRUserJwtData.fromJson(json["jwt_data"])
            : null);
  }
}
