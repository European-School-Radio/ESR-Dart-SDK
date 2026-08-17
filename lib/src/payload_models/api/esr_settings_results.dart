import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRSettingsBySettingKeyResults {
  String status = "";
  ESRSetting? setting;

  ESRSettingsBySettingKeyResults({
    required this.status,
    required this.setting
  });

  factory ESRSettingsBySettingKeyResults.fromJson(Map<String, dynamic> json){
    return ESRSettingsBySettingKeyResults(
      status: json['status'],
      setting: ESRSetting.fromJson(json['setting'])
    );
  }
}