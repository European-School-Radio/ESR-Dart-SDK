import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/esr_environments.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/ip_utils.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRSSOLoginTriesService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRSSOLoginTriesService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRSSOLoginTriesAddResult> addSsoLoginTry(ESRSSOLoginTry loginTry) async {
    final urlBuilder = UrlBuilder('$_apiURL/sso-login-tries/add');

    String userIP = await ESRIPUtils.getIP();

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'sso_model': loginTry.ssoModel,
      'first_name': loginTry.firstName,
      'last_name': loginTry.lastName,
      'username': loginTry.username,
      'email': loginTry.email,
      'phone_number': loginTry.phoneNumber,
      'sso_role_position': loginTry.ssoRolePosition,
      'sso_profile_url': loginTry.ssoProfileUrl,
      'error_code': loginTry.errorCode.toString(),
      'ip_address': userIP,
      'user_agent': "${sdk.env.fullNameApplication} Application/${sdk.appVersion} (Dart SDK/${sdk.sdkVersion})",
      'from_mobile': loginTry.fromMobile ? "1" : "0",
      'api_key': sdk.ssoApiKey
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRSSOLoginTriesAddResult.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}