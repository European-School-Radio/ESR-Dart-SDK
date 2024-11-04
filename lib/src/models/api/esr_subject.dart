class ESRSubject {
  int id = 0;
  String name = "";
  String? description = "";
  bool disabled = false;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRSubject({
    required this.id,
    required this.name,
    required this.description,
    required this.disabled,
    required this.created,
    required this.updated
  });

  factory ESRSubject.fromJson(Map<String, dynamic> json){
    return ESRSubject(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        disabled: json['disabled'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated'])
    );
  }
}