class ESRGender {
  int id = 0;
  String name = "";
  String description = "";
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRGender({
    required this.id,
    required this.name,
    required this.description,
    required this.created,
    required this.updated
  });
  
  factory ESRGender.fromJson(Map<String, dynamic> json){
    return ESRGender(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated'])
    );
  }
}