import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';

class ESRZoneProductionType {
  int id = 0;
  ESRZone? zone;
  ESRProductionType productionType;
  DateTime created;
  DateTime updated;
  
  ESRZoneProductionType({
    required this.id,
    required this.zone,
    required this.productionType,
    required this.created,
    required this.updated
  });
  
  factory ESRZoneProductionType.fromJson(Map<String, dynamic> json){
    return ESRZoneProductionType(
      id: json["id"],
      zone: IsNumericUtils.isNumeric(json["zone"].toString()) ? null : ESRZone.fromJson(json["zone"]),
      productionType: ESRProductionType.fromJson(json["production_type"]),
      created: DateTime.parse(json["created"]),
      updated: DateTime.parse(json["updated"])
    );
  }
}