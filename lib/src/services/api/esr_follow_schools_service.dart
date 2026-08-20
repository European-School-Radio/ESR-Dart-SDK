import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRFollowSchoolsService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRFollowSchoolsService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRFollowSchoolCheckFollowedSchoolResults> checkUserFollowedSchool(int userID, int schoolID, String jwt) async {
    if (userID == 0 || schoolID == 0 || jwt.isEmpty){
      throw InformationNotValidException("Information not valid");
    }

    final urlBuilder = UrlBuilder('$_apiURL/follow-school/userFollowedSchool');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $jwt'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      "user_id": userID.toString(),
      "school_id": schoolID.toString()
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRFollowSchoolCheckFollowedSchoolResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRFollowSchoolAddResults> addFollowSchool(int userID, int schoolID, String jwt) async {
    if (userID == 0 || schoolID == 0 || jwt.isEmpty){
      throw InformationNotValidException("Information not valid");
    }

    final urlBuilder = UrlBuilder('$_apiURL/follow-school/add');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $jwt'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      "user": userID.toString(),
      "school": schoolID.toString()
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRFollowSchoolAddResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRFollowSchoolDeleteResults> removeFollowSchool(int likeSchoolID, String jwt) async {
    if (likeSchoolID == 0 || jwt.isEmpty){
      throw InformationNotValidException("Information not valid");
    }

    final urlBuilder = UrlBuilder('$_apiURL/follow-school/delete/$likeSchoolID');

    var headers = {
      'Authorization': 'Bearer $jwt'
    };
    var request = http.Request('DELETE', Uri.parse(urlBuilder.build()));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRFollowSchoolDeleteResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}