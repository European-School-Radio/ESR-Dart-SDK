import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRUserSchoolsActiveSchoolsResults {
  String status;
  List<ESRUsersSchools> userSchools;

  ESRUserSchoolsActiveSchoolsResults(
      {required this.status,
      required this.userSchools});

  factory ESRUserSchoolsActiveSchoolsResults.fromJson(
      Map<String, dynamic> json) {
    List<dynamic> userSchoolsList = json['user_schools'] as List<dynamic>;

    return ESRUserSchoolsActiveSchoolsResults(
      status: json["status"],
      userSchools: userSchoolsList
          .map((singleUserSchool) => ESRUsersSchools.fromJson(singleUserSchool as Map<String, dynamic>))
          .where((item) => !item.disabled)
          .toList()
    );
  }
}
