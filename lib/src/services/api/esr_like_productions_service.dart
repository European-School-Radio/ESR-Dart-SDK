import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRLikeProductionsService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRLikeProductionsService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRLikeProductionCheckLikedProductionResults> checkUserLikedProduction(int userID, int productionID) async {
    final urlBuilder = UrlBuilder('$_apiURL/like-production/userLikedProduction');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      "user_id": userID.toString(),
      "production_id": productionID.toString()
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRLikeProductionCheckLikedProductionResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRLikeProductionAddResults> addLikeProduction(int userID, int productionID, String jwt) async {
    final urlBuilder = UrlBuilder('$_apiURL/like-production/add');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $jwt'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      "user": userID.toString(),
      "production": productionID.toString()
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRLikeProductionAddResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}