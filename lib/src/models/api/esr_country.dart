class ESRCountry {
  int id = 0;
  String name = "";
  String code = "";
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRCountry({
    required this.id,
    required this.name,
    required this.code,
    required this.created,
    required this.updated
  });

  factory ESRCountry.fromJson(Map<String, dynamic> json){
    return ESRCountry(
        id: json['id'],
        name: json['name'],
        code: json['code'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated'])
    );
  }
}