class ESRClassificationCategory {
  int id = 0;
  String uniqueName = "";
  String name = "";
  String description = "";
  bool disabled = false;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRClassificationCategory({
    required this.id,
    required this.uniqueName,
    required this.name,
    required this.description,
    required this.disabled,
    required this.created,
    required this.updated
  });

  factory ESRClassificationCategory.fromJson(Map<String, dynamic> json){
    return ESRClassificationCategory(
      id: json['id'],
      uniqueName: json['unique_name'],
      name: json['name'],
      description: json['description'],
      disabled: json['disabled'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
    );
  }
}