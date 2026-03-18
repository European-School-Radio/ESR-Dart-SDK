import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRUserSetting {
  int id = 0;
  ESRUser? user;
  String settingKey = "";
  String settingValue = "";
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRUserSetting({
    required this.id,
    this.user,
    required this.settingKey,
    required this.settingValue,
    required this.created,
    required this.updated
  });

  factory ESRUserSetting.fromJson(Map<String, dynamic> json){
    return ESRUserSetting(
      id: json['id'],
      user: (json['user'] != null) ? ESRUser.fromJson(json['user']) : null,
      settingKey: json['setting_key'],
      settingValue: json['setting_value'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated'])
    );
  }
}