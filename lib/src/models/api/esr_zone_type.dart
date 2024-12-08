class ESRZoneType {
  int id = 0;
  String name = "";
  bool isVisible = false;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRZoneType({
    required this.id,
    required this.name,
    required this.isVisible,
    required this.created,
    required this.updated
  });

  factory ESRZoneType.fromJson(Map<String, dynamic> json){
    return ESRZoneType(
        id: json['id'],
        name: json['name'],
        isVisible: json['is_visible'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated'])
    );
  }
}