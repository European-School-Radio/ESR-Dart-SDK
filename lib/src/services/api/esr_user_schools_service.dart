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
}