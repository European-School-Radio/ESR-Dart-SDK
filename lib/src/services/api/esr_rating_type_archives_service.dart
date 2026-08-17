import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRRatingTypeArchivesService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRRatingTypeArchivesService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRRatingTypeArchiveByUserArchiveResults> getByUserArchive(int userID, int archiveID, List<int> ratingTypes, String jwt) async {
    final urlBuilder = UrlBuilder('$_apiURL/rating-types-archive/byUserArchive');
    urlBuilder.addQueryParam("user_id", userID.toString());
    urlBuilder.addQueryParam("archive_id", userID.toString());
    urlBuilder.addQueryParam("all_rating_types", ratingTypes.join(","));
    urlBuilder.addQueryParam("application_request", sdk.env == ESREnvironments.youthRadio ? "YouthRadio" : "European_School_Radio");

    var headers = {
      "Authorization": "Bearer $jwt"
    };

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRRatingTypeArchiveByUserArchiveResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRRatingTypeArchiveAddResults> addRatingTypeArchive(int archiveID, int userID, int ratingTypeID, double ratingValue, String jwt) async {
    final urlBuilder = UrlBuilder('$_apiURL/rating-types-archive/add');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $jwt'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'archive': archiveID.toString(),
      'rating_type': ratingTypeID.toString(),
      'user': userID.toString(),
      'rating_value': ratingValue.toString(),
      'application_request': sdk.env == ESREnvironments.youthRadio ? "YouthRadio" : "European_School_Radio"
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRRatingTypeArchiveAddResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRRatingTypeArchiveEditResults> editRatingTypeArchive(int id, double ratingValue, String jwt) async {
    final urlBuilder = UrlBuilder('$_apiURL/rating-types-archive/edit/$id');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $jwt'
    };
    var request = http.Request('PUT', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'rating_value': ratingValue.toString(),
      'application_request': sdk.env == ESREnvironments.youthRadio ? "YouthRadio" : "European_School_Radio"
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRRatingTypeArchiveEditResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRRatingTypeArchiveDeleteResults> deleteRatingTypeArchive(int id, String jwt) async {
    final urlBuilder = UrlBuilder('$_apiURL/rating-types-archive/delete/$id?application_request=${sdk.env == ESREnvironments.youthRadio ? "YouthRadio" : "European_School_Radio"}');

    var headers = {
      'Authorization': 'Bearer $jwt'
    };
    var request = http.Request('DELETE', Uri.parse(urlBuilder.build()));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRRatingTypeArchiveDeleteResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}