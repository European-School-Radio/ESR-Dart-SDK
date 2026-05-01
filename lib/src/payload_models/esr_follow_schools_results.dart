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