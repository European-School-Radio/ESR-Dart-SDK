import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRArchiveUserSchools {
  int id = 0;
  ESRUsersSchools? userSchool;
  ESRArchive? archive;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRArchiveUserSchools({
    required this.id,
    required this.userSchool,
    required this.archive,
    required this.created,
    required this.updated
  });
  
  factory ESRArchiveUserSchools.fromJson(Map<String, dynamic> json){
    return ESRArchiveUserSchools(
      id: json['id'],
      userSchool: ESRUsersSchools.fromJson(json['user_school']),
      archive: ESRArchive.fromJson(json['archive']),
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
    );
  }
}