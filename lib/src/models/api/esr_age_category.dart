class ESRAgeCategory {
  int id = 0;
  String name = "";
  String description = "";
  bool disabled = false;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRAgeCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.disabled,
    required this.created,
    required this.updated
  });

  factory ESRAgeCategory.fromJson(Map<String, dynamic> json){
    return ESRAgeCategory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      disabled: json['disabled'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
    );
  }
}