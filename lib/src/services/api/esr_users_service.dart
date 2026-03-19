import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRUsersService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRUsersService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRUsersLoginResults> loginUsername(String username, String password) async {
    final urlBuilder = UrlBuilder('$_apiURL/users/login');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'username': username,
      'password': password,
      'request_application': sdk.env == ESREnvironments.youthRadio ? "YouthRadio" : "European_School_Radio"
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUsersLoginResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRUsersLoginResults> loginEmail(String email, String password) async {
    if (!EmailValidator.validate(email)){
      throw InformationNotValidException("Email Address is not valid");
    }

    final urlBuilder = UrlBuilder('$_apiURL/users/login-email');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'email': email,
      'password': password,
      'request_application': sdk.env == ESREnvironments.youthRadio ? "Youth_Radio" : "European_School_Radio"
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUsersLoginResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRUsersPublicProfile> getPublicProfileById(int id, {ESRLang? language}) async {
    final urlBuilder = UrlBuilder('$_apiURL/users/publicProfile/$id');

    if (language != null){
      urlBuilder.addQueryParam("lang", language.flag);
    } else {
      urlBuilder.addQueryParam("lang", "en");
    }

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUsersPublicProfile.fromJson(jsonData);
    } else if (response.statusCode == 404) {
      throw ObjectNotFoundException("User with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRUserCoverDataResults> getUserCoverById(int id) async {
    final urlBuilder = UrlBuilder('${ESRServerConfig.communityBaseUrl}/wp-json/custom/get/user/cover/$id');

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUserCoverDataResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRUsersSimilarUsersResults> getSimilarUsersById(int id, {int? maxItems, ESRLang? language}) async {
    final urlBuilder = UrlBuilder('$_apiURL/users/find-similar/$id');

    if (maxItems != null){
      urlBuilder.addQueryParam("max_results", maxItems.toString());
    } else {
      urlBuilder.addQueryParam("max_results", "5");
    }

    if (language != null){
      urlBuilder.addQueryParam("lang", language.flag);
    } else {
      urlBuilder.addQueryParam("lang", "en");
    }

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUsersSimilarUsersResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}