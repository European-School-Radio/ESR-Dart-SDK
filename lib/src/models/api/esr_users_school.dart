import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';

class ESRUsersSchools {
  int id = 0;
  ESRUser? user;
  ESRSchool? school;
  ESRRole? role;
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
        user: IsNumericUtils.isNumeric(json['user'].toString()) ? null : ESRUser.fromJson(json['user']),
        school: IsNumericUtils.isNumeric(json['school'].toString()) ? null : ESRSchool.fromJson(json['school']),
        role: IsNumericUtils.isNumeric(json['role'].toString()) ? null : ESRRole.fromJson(json['role']),
        disabled: json['disabled'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated'])
    );
  }
}