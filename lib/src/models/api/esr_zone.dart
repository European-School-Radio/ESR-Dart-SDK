import 'package:esr_dart_sdk/src/models/api/esr_zone_type.dart';

class ESRZone {
  int id = 0;
  String name = "";
  String? description;
  String color = "";
  ESRZoneType zoneType;
  bool disabled = false;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRZone({
    required this.id,
    required this.name,
    this.description,
    required this.color,
    required this.zoneType,
    required this.disabled,
    required this.created,
    required this.updated
  });

  factory ESRZone.fromJson(Map<String, dynamic> json){
    return ESRZone(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        color: json['color'],
        zoneType: ESRZoneType.fromJson(json['zone_type']),
        disabled: json['disabled'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated']),
    );
  }
}