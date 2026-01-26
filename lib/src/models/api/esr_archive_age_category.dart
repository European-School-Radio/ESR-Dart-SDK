import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';

class ESRArchiveAgeCategory {
  int id = 0;
  ESRAgeCategory? ageCategory;
  ESRArchive? archive;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRArchiveAgeCategory({
    required this.id,
    required this.ageCategory,
    required this.archive,
    required this.created,
    required this.updated
  });

  factory ESRArchiveAgeCategory.fromJson(Map<String, dynamic> json){
    return ESRArchiveAgeCategory(
      id: json['id'],
      ageCategory: IsNumericUtils.isNumeric(json['age_category']) ? null : ESRAgeCategory.fromJson(json['age_category']),
      archive: IsNumericUtils.isNumeric(json['archive']) ? null : ESRArchive.fromJson(json['archive']),
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
    );
  }
}