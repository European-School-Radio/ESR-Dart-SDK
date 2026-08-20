import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/directions/esr_sorting_directions.dart';
import 'package:esr_dart_sdk/src/enums/sorting/esr_rating_type_sorting.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRRatingTypesService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRRatingTypesService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRRatingTypesPaginatedResults> getAllRatingTypes({ int? page, int? limit, ESRRatingTypeSorting? sort, ESRSortingDirections? direction }) async {
    final urlBuilder = UrlBuilder('$_apiURL/rating-types');

    if (page != null && page != 0){
      urlBuilder.addQueryParam("page", page.toString());
    }

    if (limit != null && limit != 0){
      urlBuilder.addQueryParam("limit", limit.toString());
    }

    if (sort != null){
      urlBuilder.addQueryParam("sort", sort.value.toString());
    }

    if (direction != null){
      urlBuilder.addQueryParam("direction", direction.value.toString());
    }

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRRatingTypesPaginatedResults.fromJson(jsonData, limit);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}