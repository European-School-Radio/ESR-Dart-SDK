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

class ESRUsersRequestResetPasswordResults {
  String status = "";
  String message = "";

  ESRUsersRequestResetPasswordResults({
    required this.status,
    required this.message
  });

  factory ESRUsersRequestResetPasswordResults.fromJson(Map<String, dynamic> json){
    return ESRUsersRequestResetPasswordResults(
      status: json['status'],
      message: json['message']
    );
  }
}

class ESRUsersCheckResetTokenValidityResults {
  String status = "";

  ESRUsersCheckResetTokenValidityResults({
    required this.status
  });

  factory ESRUsersCheckResetTokenValidityResults.fromJson(Map<String, dynamic> json){
    return ESRUsersCheckResetTokenValidityResults(
      status: json['status']
    );
  }
}

class ESRUsersCancelResetTokenResults {
  String status = "";
  String message = "";

  ESRUsersCancelResetTokenResults({
    required this.status,
    required this.message
  });

  factory ESRUsersCancelResetTokenResults.fromJson(Map<String, dynamic> json){
    return ESRUsersCancelResetTokenResults(
      status: json['status'],
      message: json['message']
    );
  }
}

class ESRUsersResetPasswordResults {
  String status = "";
  String message = "";

  ESRUsersResetPasswordResults({
    required this.status,
    required this.message
  });

  factory ESRUsersResetPasswordResults.fromJson(Map<String, dynamic> json){
    return ESRUsersResetPasswordResults(
        status: json['status'],
        message: json['message']
    );
  }
}

class ESRUsersCommunityRegisterResults {
  String message = "";
  int userID = 0;

  ESRUsersCommunityRegisterResults({
    required this.message,
    required this.userID
  });

  factory ESRUsersCommunityRegisterResults.fromJson(Map<String, dynamic> json){
    return ESRUsersCommunityRegisterResults(
      message: json['message'],
      userID: (json.containsKey("user_id")) ? json['user_id'] : 0
    );
  }
}

class ESRUsersCheckUsernameResults {
  String status = "";
  String message = "";
  bool exists = false;

  ESRUsersCheckUsernameResults({
    required this.status,
    required this.message,
    required this.exists
  });

  factory ESRUsersCheckUsernameResults.fromJson(Map<String, dynamic> json){
    return ESRUsersCheckUsernameResults(
      status: json['status'],
      message: json['message'],
      exists: json['exists']
    );
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

class ESRUsersPublicProfile {
  String status = "";
  ESRUserPublicProfile? userDetails;

  ESRUsersPublicProfile({
    required this.status,
    required this.userDetails
  });
  
  factory ESRUsersPublicProfile.fromJson(Map<String, dynamic> json){
    return ESRUsersPublicProfile(
      status: json['status'],
      userDetails: ESRUserPublicProfile.fromJson(json['user_details'])
    );
  }
}

class ESRUserCoverDataResults {
  String? coverURL;

  ESRUserCoverDataResults({
    required this.coverURL
  });

  factory ESRUserCoverDataResults.fromJson(Map<String, dynamic> json){
    return ESRUserCoverDataResults(
      coverURL: (json['cover_url'] != false) ? json['cover_url'] : null
    );
  }
}

class ESRUsersSimilarUsersResults {
  String status = "";
  List<ESRUserPublicProfile> similarUsers = [];

  ESRUsersSimilarUsersResults({
    required this.status,
    required this.similarUsers
  });

  factory ESRUsersSimilarUsersResults.fromJson(Map<String, dynamic> json){
    List<dynamic> usersList = json['similar_users'] as List<dynamic>;

    List<ESRUserPublicProfile> serializedUsers = usersList
        .map((singleUser) => ESRUserPublicProfile.fromJson(singleUser as Map<String, dynamic>))
        .toList();

    return ESRUsersSimilarUsersResults(
      status: json['status'],
      similarUsers: serializedUsers
    );
  }
}