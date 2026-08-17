class ESRSetting {
  int id = 0;
  String settingKey = "";
  String settingValue = "";
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRSetting({
    required this.id,
    required this.settingKey,
    required this.settingValue,
    required this.created,
    required this.updated
  });

  factory ESRSetting.fromJson(Map<String, dynamic> json){
    return ESRSetting(
      id: json['id'],
      settingKey: json['setting_key'],
      settingValue: json['setting_value'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated'])
    );
  }
}