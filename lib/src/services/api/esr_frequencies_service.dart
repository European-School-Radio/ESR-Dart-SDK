import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/directions/esr_sorting_directions.dart';
import 'package:esr_dart_sdk/src/enums/sorting/esr_frequency_sorting.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRFrequenciesService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRFrequenciesService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRFrequenciesPaginatedResults> getAllFrequencies({
    int? page,
    int? limit,
    ESRLang? language,
    ESRFrequencySorting? sorting,
    ESRSortingDirections? direction
  }) async {
    final urlBuilder = UrlBuilder('$_apiURL/frequencies');

    if (language != null){
      urlBuilder.addQueryParam("lang", language.flag.toString());
    } else {
      urlBuilder.addQueryParam("lang", "en");
    }

    if (page != null){
      urlBuilder.addQueryParam("page", page.toString());
    }

    if (limit != null){
      urlBuilder.addQueryParam("limit", limit.toString());
    }

    if (sorting != null){
      urlBuilder.addQueryParam("sort", sorting.value.toString());
    }

    if (direction != null){
      urlBuilder.addQueryParam("direction", direction.value.toString());
    }

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRFrequenciesPaginatedResults.fromJson(jsonData, limit);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRFrequency> getFrequencyById(int id, {ESRLang? language}) async {
    final urlBuilder = UrlBuilder('$_apiURL/frequency/$id');

    if (language == null){
      urlBuilder.addQueryParam("lang", "en");
    } else {
      urlBuilder.addQueryParam("lang", language.flag);
    }

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRFrequency.fromJson(jsonData['frequency']);
    } else if (response.statusCode == 404){
      throw ObjectNotFoundException("Frequency with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}