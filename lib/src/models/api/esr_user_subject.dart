import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';

class ESRUserSubject {
  int id = 0;
  ESRSubject? subject;
  ESRUser? user;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRUserSubject({
    required this.id,
    required this.subject,
    required this.user,
    required this.created,
    required this.updated
  });
  
  factory ESRUserSubject.fromJson(Map<String, dynamic> json){
    return ESRUserSubject(
      id: json['id'],
      subject: IsNumericUtils.isNumeric(json['subject'].toString()) ? null : ESRSubject.fromJson(json['subject']),
      user: IsNumericUtils.isNumeric(json['user'].toString()) ? null : ESRUser.fromJson(json['user']),
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated'])
    );
  }
}

class ESRUserSubjectAdd {
  int subjectID = 0;
  int userID = 0;

  ESRUserSubjectAdd({
    required this.subjectID,
    required this.userID
  });
}