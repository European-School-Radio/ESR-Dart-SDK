import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRFollowSchoolsPaginatedResults {
  int count = 0;
  List<ESRFollowSchool>? followSchools;

  ESRFollowSchoolsPaginatedResults({
    required this.count,
    required this.followSchools
  });

  factory ESRFollowSchoolsPaginatedResults.fromJson(Map<String, dynamic> json){
    List<dynamic> followSchoolsList = json['data'] as List<dynamic>;
    List<ESRFollowSchool> serializedSchoolFollows = [];

    serializedSchoolFollows = followSchoolsList
        .map((singleFollowSchool) => ESRFollowSchool.fromJson(singleFollowSchool as Map<String, dynamic>))
        .toList();

    return ESRFollowSchoolsPaginatedResults(
        count: json['count'] ?? 0,
        followSchools: serializedSchoolFollows
    );
  }
}

class ESRFollowSchoolCheckFollowedSchoolResults {
  String status = "";
  bool userFollowedSchool = false;
  ESRFollowSchool? followSchoolDetails;

  ESRFollowSchoolCheckFollowedSchoolResults({
    required this.status,
    required this.userFollowedSchool,
    required this.followSchoolDetails
  });

  factory ESRFollowSchoolCheckFollowedSchoolResults.fromJson(Map<String, dynamic> json){
    return ESRFollowSchoolCheckFollowedSchoolResults(
        status: json['status'],
        userFollowedSchool: json['user_followed_school'],
        followSchoolDetails: (json['follow_school_details'] == null) ? null : ESRFollowSchool.fromJson(json['follow_school_details'])
    );
  }
}

class ESRFollowSchoolAddResults {
  String status = "";
  String message = "";
  ESRFollowSchool? followSchool;

  ESRFollowSchoolAddResults({
    required this.status,
    required this.message,
    required this.followSchool
  });

  factory ESRFollowSchoolAddResults.fromJson(Map<String, dynamic> json){
    return ESRFollowSchoolAddResults(
        status: json['status'],
        message: json['message'],
        followSchool: ESRFollowSchool.fromJson(json['follow_school'])
    );
  }
}

class ESRFollowSchoolDeleteResults {
  String status = "";
  String message = "";

  ESRFollowSchoolDeleteResults({
    required this.status,
    required this.message
  });

  factory ESRFollowSchoolDeleteResults.fromJson(Map<String, dynamic> json){
    return ESRFollowSchoolDeleteResults(
        status: json['status'],
        message: json['message']
    );
  }
}