import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';

class ESRZoneSubject {
  int id = 0;
  ESRZone? zone;
  ESRSubject subject;
  DateTime created;
  DateTime updated;

  ESRZoneSubject({
    required this.id,
    required this.zone,
    required this.subject,
    required this.created,
    required this.updated
  });

  factory ESRZoneSubject.fromJson(Map<String, dynamic> json){
    return ESRZoneSubject(
      id: json["id"],
      zone: IsNumericUtils.isNumeric(json["zone"].toString()) ? null : ESRZone.fromJson(json["zone"]),
      subject: ESRSubject.fromJson(json["subject"]),
      created: DateTime.parse(json["created"]),
      updated: DateTime.parse(json["updated"])
    );
  }
}