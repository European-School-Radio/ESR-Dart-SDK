class ESRWeekday {
  int id = 0;
  String name = "";
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRWeekday({
    required this.id,
    required this.name,
    required this.created,
    required this.updated
  });

  factory ESRWeekday.fromJson(Map<String, dynamic> json){
    return ESRWeekday(
        id: json['id'],
        name: json['name'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated'])
    );
  }
}