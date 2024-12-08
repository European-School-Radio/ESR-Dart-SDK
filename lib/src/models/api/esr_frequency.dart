class ESRFrequency {
  int id = 0;
  String name = "";
  String? description = "";
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRFrequency({
    required this.id,
    required this.name,
    required this.description,
    required this.created,
    required this.updated
  });

  factory ESRFrequency.fromJson(Map<String, dynamic> json){
    return ESRFrequency(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated'])
    );
  }
}