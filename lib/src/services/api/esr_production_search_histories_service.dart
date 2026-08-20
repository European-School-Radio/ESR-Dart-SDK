import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRProductionSearchHistoriesService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRProductionSearchHistoriesService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRProductionSearchHistoriesByUserResults> getSearchHistoriesByUser(int userID, String jwt, {int? limit}) async {
    if (userID == 0 || jwt.isEmpty){
      throw InformationNotValidException("Information not valid");
    }

    final urlBuilder = UrlBuilder('$_apiURL/production-search-history/byUser/$userID');

    var headers = {
      "Authorization": "Bearer $jwt"
    };

    if (limit != null && limit != 0){
      urlBuilder.addQueryParam("limit", limit.toString());
    }

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRProductionSearchHistoriesByUserResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}