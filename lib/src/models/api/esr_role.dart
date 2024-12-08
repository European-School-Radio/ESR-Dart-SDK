class ESRRole {
  int id = 0;
  String name = "";
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRRole({
    required this.id,
    required this.name,
    required this.created,
    required this.updated
  });

  factory ESRRole.fromJson(Map<String, dynamic> json){
    return ESRRole(
        id: json['id'],
        name: json['name'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated'])
    );
  }
}