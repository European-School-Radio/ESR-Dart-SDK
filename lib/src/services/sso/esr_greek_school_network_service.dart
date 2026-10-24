import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/esr_environments.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRGreekSchoolNetworkService {
  final sdk = ESRSDK();
  String _baseURL = "";

  ESRGreekSchoolNetworkService(){
    _baseURL = ESRServerConfig.externalSSOBaseUrl;
  }

  Future<ESRGreekSchoolNetworkGetCallbackResults> getLoginCallbackURL() async {
    final urlBuilder = UrlBuilder('$_baseURL/api/v1/greek-school-network/callback');
    
    urlBuilder.addQueryParam("source_platform", sdk.env.sourceApplicationURL.toString());
    urlBuilder.addQueryParam("is_mobile", "1");

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      
      return ESRGreekSchoolNetworkGetCallbackResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRGreekSchoolNetworkGetLogoutResults> getLogoutCallbackURL() async {
    final urlBuilder = UrlBuilder('$_baseURL/api/v1/greek-school-network/logout-url');

    urlBuilder.addQueryParam("source_platform", sdk.env.sourceApplicationURL.toString());
    urlBuilder.addQueryParam("is_mobile", "1");

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);

      return ESRGreekSchoolNetworkGetLogoutResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}