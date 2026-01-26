import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';

class ESRArchiveLanguage {
  int id = 0;
  ESRLang? language;
  ESRArchive? archive;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRArchiveLanguage({
    required this.id,
    required this.language,
    required this.archive,
    required this.created,
    required this.updated
  });

  factory ESRArchiveLanguage.fromJson(Map<String, dynamic> json){
    return ESRArchiveLanguage(
      id: json['id'],
      language: IsNumericUtils.isNumeric(json['language'].toString()) ? null : ESRLang.fromJson(json['language']),
      archive: IsNumericUtils.isNumeric(json['archive'].toString()) ? null : ESRArchive.fromJson(json['archive']),
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
    );
  }
}