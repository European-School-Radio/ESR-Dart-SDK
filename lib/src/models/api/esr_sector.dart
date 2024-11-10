class ESRSector {
  int id = 0;
  String name = "";
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRSector({
    required this.id,
    required this.name,
    required this.created,
    required this.updated
  });

  factory ESRSector.fromJson(Map<String, dynamic> json){
    return ESRSector(
        id: json['id'],
        name: json['name'],
        created: DateTime.parse(json['created']).toLocal(),
        updated: DateTime.parse(json['updated']).toLocal()
    );
  }
}