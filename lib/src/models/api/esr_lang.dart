class ESRLang {
  int id = 0;
  String name = "";
  String nativeName = "";
  String code = "";
  String flag = "";
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRLang({
    required this.id,
    required this.name,
    required this.nativeName,
    required this.code,
    required this.flag,
    required this.created,
    required this.updated
  });

  factory ESRLang.fromJson(Map<String, dynamic> json){
    return ESRLang(
        id: json['id'],
        name: json['name'],
        nativeName: json['native_name'],
        code: json['code'],
        flag: json['flag'],
        created: DateTime.parse(json['created']).toLocal(),
        updated: DateTime.parse(json['updated']).toLocal()
    );
  }
}