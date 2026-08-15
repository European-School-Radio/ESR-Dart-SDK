class ESRReportReason {
  int id = 0;
  String name = "";
  String description = "";
  bool needsDescription = false;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRReportReason({
    required this.id,
    required this.name,
    required this.description,
    required this.needsDescription,
    required this.created,
    required this.updated
  });

  factory ESRReportReason.fromJson(Map<String, dynamic> json){
    return ESRReportReason(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      needsDescription: json['needs_description'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated'])
    );
  }
}