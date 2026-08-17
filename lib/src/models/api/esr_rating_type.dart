class ESRRatingType {
  int id = 0;
  String name = "";
  String description = "";
  bool disabled = false;
  bool inAverage = false;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRRatingType({
    required this.id,
    required this.name,
    required this.description,
    required this.disabled,
    required this.inAverage,
    required this.created,
    required this.updated
  });

  factory ESRRatingType.fromJson(Map<String, dynamic> json){
    return ESRRatingType(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      disabled: json['disabled'],
      inAverage: json['in_average'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated'])
    );
  }
}