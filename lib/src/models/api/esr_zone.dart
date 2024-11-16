import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRZone {
  int id = 0;
  String name = "";
  String? description;
  String color = "";
  ESRZoneType zoneType;
  bool disabled = false;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();
  List<ESRZoneSubject> zoneSubjects;
  List<ESRZoneProductionType> zoneProductionTypes;
  List<ESRZoneSchedules> zoneSchedules;

  ESRZone(
      {required this.id,
      required this.name,
      this.description,
      required this.color,
      required this.zoneType,
      required this.disabled,
      required this.created,
      required this.updated,
      required this.zoneSubjects,
      required this.zoneProductionTypes,
      required this.zoneSchedules});

  factory ESRZone.fromJson(Map<String, dynamic> json) {
    List<ESRZoneSubject> serializedZoneSubjects = (json['zone_subjects']
            as List<dynamic>)
        .map((singleZoneSubject) =>
            ESRZoneSubject.fromJson(singleZoneSubject as Map<String, dynamic>))
        .toList();
    List<ESRZoneProductionType> serializedZoneProductionTypes =
        (json['zone_production_types'] as List<dynamic>)
            .map((singleZoneProductionType) => ESRZoneProductionType.fromJson(
                singleZoneProductionType as Map<String, dynamic>))
            .toList();
    List<ESRZoneSchedules> serializedZoneSchedules =
        (json['zone_schedules'] as List<dynamic>)
            .map((singleZoneSchedule) => ESRZoneSchedules.fromJson(
                singleZoneSchedule as Map<String, dynamic>))
            .toList();

    return ESRZone(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        color: json['color'],
        zoneType: ESRZoneType.fromJson(json['zone_type']),
        disabled: json['disabled'],
        created: DateTime.parse(json['created']).toLocal(),
        updated: DateTime.parse(json['updated']).toLocal(),
        zoneSubjects: serializedZoneSubjects,
        zoneProductionTypes: serializedZoneProductionTypes,
        zoneSchedules: serializedZoneSchedules);
  }
}
