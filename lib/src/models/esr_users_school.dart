import 'package:esr_dart_sdk/src/models/esr_role.dart';
import 'package:esr_dart_sdk/src/models/esr_school.dart';
import 'package:esr_dart_sdk/src/models/esr_user.dart';

class ESRUsersSchools {
  int id = 0;
  ESRUser user;
  ESRSchool school;
  ESRRole role;
  bool disabled = false;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRUsersSchools({
    required this.id,
    required this.user,
    required this.school,
    required this.role,
    required this.disabled,
    required this.created,
    required this.updated
  });

  factory ESRUsersSchools.fromJson(Map<String, dynamic> json){
    return ESRUsersSchools(
        id: json['id'],
        user: ESRUser.fromJson(json['user']),
        school: ESRSchool.fromJson(json['school']),
        role: ESRRole.fromJson(json['role']),
        disabled: json['disabled'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated']),
    );
  }
}