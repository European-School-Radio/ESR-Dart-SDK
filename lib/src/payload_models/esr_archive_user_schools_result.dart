import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRArchiveUserSchoolsListResults {
  int count = 0;
  List<ESRArchiveUserSchools>? archiveUserSchools;

  ESRArchiveUserSchoolsListResults({
    required this.count,
    required this.archiveUserSchools
  });

  factory ESRArchiveUserSchoolsListResults.fromJson(Map<String, dynamic> json){
    List<dynamic> archiveUserSchoolList = json['data'] as List<dynamic>;
    List<ESRArchiveUserSchools> serializedArchiveUserSchools = [];

    serializedArchiveUserSchools = archiveUserSchoolList
        .map((singleArchiveUserSchool) => ESRArchiveUserSchools.fromJson(singleArchiveUserSchool as Map<String, dynamic>))
        .toList();

    return ESRArchiveUserSchoolsListResults(
      count: json['count'] ?? 0,
      archiveUserSchools: serializedArchiveUserSchools
    );
  }
}