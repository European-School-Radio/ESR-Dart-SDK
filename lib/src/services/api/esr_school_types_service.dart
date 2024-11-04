import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/directions/esr_sorting_directions.dart';
import 'package:esr_dart_sdk/src/enums/sorting/esr_school_type_sorting.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRSchoolTypesService {
  String _apiURL = "";

  ESRSchoolTypesService(){
    _apiURL = ESRServerConfig.apiUrl;
  }

  Future<ESRSchoolTypesPaginatedResults> getAllSchoolTypes({
    int? page,
    int? limit,
    ESRSchoolTypeSorting? sorting,
    ESRSortingDirections? direction
  }) async {
    final urlBuilder = UrlBuilder('$_apiURL/school-types');

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
      return ESRSchoolTypesPaginatedResults.fromJson(jsonData, limit);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRSchoolType> getSchoolTypeById(int id, {ESRLang? language}) async {
    final urlBuilder = UrlBuilder('$_apiURL/school-type/$id');

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
      return ESRSchoolType.fromJson(jsonData['school_type']);
    } else if (response.statusCode == 404){
      throw ObjectNotFoundException("School type with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}