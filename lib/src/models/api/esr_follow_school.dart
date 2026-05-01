import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRFollowSchool {
  int id = 0;
  ESRSchool? school;
  ESRUser? user;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRFollowSchool({
    required this.id,
    required this.school,
    required this.user,
    required this.created,
    required this.updated,
  });

  factory ESRFollowSchool.fromJson(Map<String, dynamic> json){
    return ESRFollowSchool(
      id: json['id'],
      school: ESRSchool.fromJson(json['school']),
      user: ESRUser.fromJson(json['user']),
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated'])
    );
  }
}