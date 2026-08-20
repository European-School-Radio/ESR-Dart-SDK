import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/directions/esr_sorting_directions.dart';
import 'package:esr_dart_sdk/src/enums/sorting/esr_report_reason_sorting.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRReportReasonsService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRReportReasonsService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRReportReasonsPaginatedResults> getAllReportReasons({
    int? page,
    int? limit,
    ESRLang? language,
    ESRReportReasonSorting? sorting,
    ESRSortingDirections? direction
  }) async {
    final urlBuilder = UrlBuilder('$_apiURL/report-reasons');

    if (language != null){
      if (language.flag.isEmpty){
        urlBuilder.addQueryParam("lang", "en");
      } else {
        urlBuilder.addQueryParam("lang", language.flag.toString());
      }
    } else {
      urlBuilder.addQueryParam("lang", "en");
    }

    if (page != null && page != 0){
      urlBuilder.addQueryParam("page", page.toString());
    }

    if (limit != null && limit != 0){
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
      return ESRReportReasonsPaginatedResults.fromJson(jsonData, limit);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRReportReason> getReportReasonById(int id, {ESRLang? language}) async {
    if (id == 0){
      throw InformationNotValidException("Information not valid");
    }

    final urlBuilder = UrlBuilder('$_apiURL/report-reason/$id');

    if (language == null){
      urlBuilder.addQueryParam("lang", "en");
    } else {
      if (language.flag.isEmpty){
        urlBuilder.addQueryParam("lang", "en");
      } else {
        urlBuilder.addQueryParam("lang", language.flag);
      }
    }

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRReportReason.fromJson(jsonData['report_reason']);
    } else if (response.statusCode == 404){
      throw ObjectNotFoundException("Report reason with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}