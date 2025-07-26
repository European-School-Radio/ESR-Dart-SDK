import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/directions/esr_sorting_directions.dart';
import 'package:esr_dart_sdk/src/enums/sorting/esr_production_sorting.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/datetime_formatter.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRProductionsService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRProductionsService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRProductionsPaginatedResults> getAllProductions({
    int? page,
    int? limit,
    ESRLang? language,
    ESRProductionSorting? sorting,
    ESRSortingDirections? direction
  }) async {
    final urlBuilder = UrlBuilder('$_apiURL/productions');

    if (page != null) {
      urlBuilder.addQueryParam("page", page.toString());
    }

    if (limit != null) {
      urlBuilder.addQueryParam("limit", limit.toString());
    }

    if (language == null) {
      urlBuilder.addQueryParam("lang", "en");
    } else {
      urlBuilder.addQueryParam("lang", language.flag);
    }

    if (sorting != null) {
      urlBuilder.addQueryParam("sort", sorting.value.toString());
    }

    if (direction != null) {
      urlBuilder.addQueryParam("direction", direction.value.toString());
    }

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRProductionsPaginatedResults.fromJson(jsonData, limit);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRProductionsPaginatedResults> searchProductions({
    String? searchQuery,
    DateTime? createdFrom,
    DateTime? createdTo,
    List<ESRSchoolType>? schoolTypes,
    List<ESRLang>? productionLanguages,
    List<ESRCountry>? schoolCountries,
    List<ESRProductionType>? productionTypes,
    List<ESRZone>? productionZones,
    List<ESRSubject>? productionSubjects,
    List<ESRFrequency>? reservationFrequency,
    bool? showSchedulable,
    bool? showPodcasts,
    bool? showSpecials,
    int? page,
    int? limit,
    ESRLang? language,
    ESRProductionSorting? sorting,
    ESRSortingDirections? direction
  }) async {
    final urlBuilder = UrlBuilder('$_apiURL/production/search');

    if (page != null) {
      urlBuilder.addQueryParam("page", page.toString());
    }

    if (limit != null) {
      urlBuilder.addQueryParam("limit", limit.toString());
    }

    if (language == null) {
      urlBuilder.addQueryParam("lang", "en");
    } else {
      urlBuilder.addQueryParam("lang", language.flag);
    }

    if (sorting != null) {
      urlBuilder.addQueryParam("sort", sorting.value.toString());
    }

    if (direction != null) {
      urlBuilder.addQueryParam("direction", direction.value.toString());
    }

    if (showSpecials != null){
      urlBuilder.addQueryParam("show_special", (showSpecials) ? "1" : "0");
    }

    if (showPodcasts != null){
      urlBuilder.addQueryParam("show_podcasts", (showPodcasts) ? "1" : "0");
    }

    if (showSchedulable != null){
      urlBuilder.addQueryParam("show_schedulable", (showSchedulable) ? "1" : "0");
    }

    if (reservationFrequency != null){
      if (reservationFrequency.isNotEmpty){
        urlBuilder.addQueryParam("reservation_frequency", reservationFrequency.map((singleFrequency) => singleFrequency.id).toSet().join(","));
      }
    }

    if (productionSubjects != null){
      if (productionSubjects.isNotEmpty){
        urlBuilder.addQueryParam("subjects", productionSubjects.map((singleSubject) => singleSubject.id).toSet().join(","));
      }
    }

    if (productionZones != null){
      if (productionZones.isNotEmpty){
        urlBuilder.addQueryParam("zone", productionZones.map((singleZone) => singleZone.id).toSet().join(","));
      }
    }

    if (productionTypes != null){
      if (productionTypes.isNotEmpty){
        urlBuilder.addQueryParam("ptype", productionTypes.map((singleProductionType) => singleProductionType.id).toSet().join(","));
      }
    }

    if (schoolCountries != null){
      if (schoolCountries.isNotEmpty){
        urlBuilder.addQueryParam("country", schoolCountries.map((singleCountry) => singleCountry.id).toSet().join(","));
      }
    }

    if (productionLanguages != null){
      if (productionLanguages.isNotEmpty){
        urlBuilder.addQueryParam("production_lang", productionLanguages.map((singleLanguage) => singleLanguage.id).toSet().join(","));
      }
    }

    if (schoolTypes != null){
      if (schoolTypes.isNotEmpty){
        urlBuilder.addQueryParam("school_type", schoolTypes.map((singleSchoolType) => singleSchoolType.id).toSet().join(","));
      }
    }

    if (createdTo != null){
      urlBuilder.addQueryParam("to", ESRDateTimeFormatter.formatDateTimeRequests(createdTo));
    }

    if (createdFrom != null){
      urlBuilder.addQueryParam("from", ESRDateTimeFormatter.formatDateTimeRequests(createdFrom));
    }

    if (searchQuery != null){
      urlBuilder.addQueryParam("q", searchQuery);
    }

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRProductionsPaginatedResults.fromJson(jsonData, limit);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRProduction> getProductionById(int id, {ESRLang? language}) async {
    final urlBuilder = UrlBuilder('$_apiURL/production/$id');

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
      return ESRProduction.fromJson(jsonData['production']);
    } else if (response.statusCode == 404){
      throw ObjectNotFoundException("Production with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}