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

class ESRUsersWebsocketListResults {
  int count = 0;
  List<ESRUser> results = [];

  ESRUsersWebsocketListResults({
    required this.count,
    required this.results
  });

  factory ESRUsersWebsocketListResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRUser> serializedUsers = [];

    if (!json.containsKey("data") || json['data'] == null){
      return ESRUsersWebsocketListResults(
          count: 0,
          results: []
      );
    }

    List<dynamic> schoolsList = json['data'] as List<dynamic>;

    serializedUsers = schoolsList
        .map((singleUser) => ESRUser.fromJson(singleUser as Map<String, dynamic>))
        .toList();

    return ESRUsersWebsocketListResults(
        count: json['count'] ?? 0,
        results: serializedUsers
    );
  }
}