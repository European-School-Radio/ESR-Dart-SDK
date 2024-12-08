class ESRSchoolType {
  int id = 0;
  String name = "";
  String? description;
  int unitsGroupId = 0;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRSchoolType({
    required this.id,
    required this.name,
    this.description,
    required this.unitsGroupId,
    required this.created,
    required this.updated
  });

  factory ESRSchoolType.fromJson(Map<String, dynamic> json){
    return ESRSchoolType(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        unitsGroupId: json['units_group_id'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated'])
    );
  }
}