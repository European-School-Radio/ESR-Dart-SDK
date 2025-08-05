import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';

class ESRProductionSubject {
  int id = 0;
  ESRSubject subject;
  ESRProduction? production;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRProductionSubject({
    required this.id,
    required this.subject,
    required this.production,
    required this.created,
    required this.updated
  });

  factory ESRProductionSubject.fromJson(Map<String, dynamic> json){
    return ESRProductionSubject(
        id: json['id'],
        subject: ESRSubject.fromJson(json['subject']),
        production: IsNumericUtils.isNumeric(json['production'].toString()) ? null : ESRProduction.fromJson(json['production']),
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated'])
    );
  }
}

class ESRAddProductionSubject {
  int subjectID;
  int productionID;

  ESRAddProductionSubject({
    required this.subjectID,
    required this.productionID
  });
}