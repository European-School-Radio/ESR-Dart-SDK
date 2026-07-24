import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';

class ESRUserSchoolApproval {
  int id = 0;
  ESRUsersSchools? userSchool;
  bool? approved;
  ESRUser? updatedBy;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRUserSchoolApproval({
    required this.id,
    required this.userSchool,
    required this.approved,
    required this.updatedBy,
    required this.created,
    required this.updated
  });

  factory ESRUserSchoolApproval.fromJson(Map<String, dynamic> json){
    return ESRUserSchoolApproval(
      id: json['id'],
      userSchool: IsNumericUtils.isNumeric(json['user_school'].toString()) ? null : ESRUsersSchools.fromJson(json['user_school']),
      approved: json['approved'],
      updatedBy: IsNumericUtils.isNumeric(json['updated_by'].toString()) ? null : ESRUser.fromJson(json['updated_by']),
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated'])
    );
  }
}