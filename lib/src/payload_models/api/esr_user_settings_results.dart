import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRUserSettingsByUserPublicResults {
  String status = "";
  List<ESRUserSetting> userSettings = [];

  ESRUserSettingsByUserPublicResults({
    required this.status,
    required this.userSettings
  });

  factory ESRUserSettingsByUserPublicResults.fromJson(Map<String, dynamic> json){
    List<ESRUserSetting> serializedUserSettings = [];

    List<dynamic> userSettingsList = (json['user_settings'] ?? json['results']) as List<dynamic>;

    serializedUserSettings = userSettingsList
        .map((singleUserSetting) => ESRUserSetting.fromJson(singleUserSetting as Map<String, dynamic>))
        .toList();

    return ESRUserSettingsByUserPublicResults(
      status: json['status'],
      userSettings: serializedUserSettings
    );
  }
}