import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';

class ESRArchiveSubject {
  int id = 0;
  ESRSubject subject;
  ESRArchive? archive;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRArchiveSubject({
    required this.id,
    required this.subject,
    required this.archive,
    required this.created,
    required this.updated
  });

  factory ESRArchiveSubject.fromJson(Map<String, dynamic> json){
    return ESRArchiveSubject(
        id: json['id'],
        subject: ESRSubject.fromJson(json['subject']),
        archive: IsNumericUtils.isNumeric(json['archive'].toString()) ? null : ESRArchive.fromJson(json['archive']),
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated'])
    );
  }
}

class ESRAddArchiveSubject {
  int subjectID;
  int archiveID;

  ESRAddArchiveSubject({
    required this.subjectID,
    required this.archiveID
  });
}