import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRUserLoginResults {
  bool success;
  String status;
  String message;
  ESRUserJwtData? jwtData;

  ESRUserLoginResults(
      {required this.success,
      required this.status,
      required this.message,
      this.jwtData});

  factory ESRUserLoginResults.fromJson(Map<String, dynamic> json) {
    return ESRUserLoginResults(
        success: (json["status"] == "success"),
        status: json["status"],
        message: json["message"],
        jwtData: (json.containsKey("jwt_data") && json["jwt_data"] != null)
            ? ESRUserJwtData.fromJson(json["jwt_data"])
            : null);
  }
}
