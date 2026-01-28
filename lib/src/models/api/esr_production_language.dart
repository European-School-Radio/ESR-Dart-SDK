import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';

class ESRProductionLanguage {
  int id = 0;
  ESRLang? language;
  ESRProduction? production;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRProductionLanguage({
    required this.id,
    required this.language,
    required this.production,
    required this.created,
    required this.updated
  });

  factory ESRProductionLanguage.fromJson(Map<String, dynamic> json){
    return ESRProductionLanguage(
      id: json['id'],
      language: IsNumericUtils.isNumeric(json['language'].toString()) ? null : ESRLang.fromJson(json['language']),
      production: IsNumericUtils.isNumeric(json['production'].toString()) ? null : ESRProduction.fromJson(json['production']),
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
    );
  }
}