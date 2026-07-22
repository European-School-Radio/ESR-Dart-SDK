import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/directions/esr_sorting_directions.dart';
import 'package:esr_dart_sdk/src/enums/sorting/esr_users_schools_sorting.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRUserSchoolsService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRUserSchoolsService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRUserSchoolsActiveSchoolsResults> getActiveUserSchoolsForUser(int userID, {ESRUsersSchoolsSorting? sorting, ESRSortingDirections? direction, ESRLang? language}) async {
    final urlBuilder = UrlBuilder('$_apiURL/user-school/byUser/$userID');

    urlBuilder.addQueryParam("page", "1");
    urlBuilder.addQueryParam("limit", "-1");

    if (sorting != null){
      urlBuilder.addQueryParam("sort", sorting.value.toString());
    }

    if (direction != null){
      urlBuilder.addQueryParam("direction", direction.value.toString());
    }

    if (language != null){
      urlBuilder.addQueryParam("lang", language.flag.toString());
    } else {
      urlBuilder.addQueryParam("lang", "en");
    }

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUserSchoolsActiveSchoolsResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRUserSchoolsAddUserToSchoolResults> addUserSchool(int userID, int schoolID, int roleID, bool disabled, String userToken) async {
    final urlBuilder = UrlBuilder('$_apiURL/user-school/add');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $userToken'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'user': userID.toString(),
      'school': schoolID.toString(),
      'role': roleID.toString(),
      'disabled': disabled ? "1" : "0"
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUserSchoolsAddUserToSchoolResults.fromJson(jsonData);
    } else if (response.statusCode == 401){
      throw UnAuthorizedException("Authentication not valid");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}