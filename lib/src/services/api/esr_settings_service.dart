import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRSettingsService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRSettingsService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRSettingsBySettingKeyResults> getSettingByKey(String settingKey) async {
    final urlBuilder = UrlBuilder('$_apiURL/setting/bySettingKey');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      "setting_key": settingKey
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRSettingsBySettingKeyResults.fromJson(jsonData);
    }  else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}