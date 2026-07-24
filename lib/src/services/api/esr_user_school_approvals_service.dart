import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRUserSchoolApprovalsService {
  final sdk = ESRSDK();
  String _apiURL = "";

  EsrUserSchoolApprovalsService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRUserSchoolApprovalsAddResults> addUserSchoolApprovals(int userSchoolID, String jwt) async {
    final urlBuilder = UrlBuilder('$_apiURL/user-school-approval/add');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $jwt'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'user_school': userSchoolID.toString(),
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUserSchoolApprovalsAddResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}