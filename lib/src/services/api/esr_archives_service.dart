import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'dart:io' as io;
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/datetime_formatter.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class ESRArchivesService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRArchivesService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRArchive> getArchiveById(int id, {ESRLang? language}) async {
    final urlBuilder = UrlBuilder('$_apiURL/archive/$id');

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

      if (jsonData['is_active_contest_submission'] != null){
        throw ContestSubmissionArchiveException("Archive $id is an active contest submission and cannot be displayed yet");
      }

      return ESRArchive.fromJson(jsonData['archive']);
    } else if (response.statusCode == 404){
      throw ObjectNotFoundException("Archive with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRArchivesAddResults> addArchive(ESRAddArchive archive, String jwt) async {
    final urlBuilder = UrlBuilder('$_apiURL/archive/add');

    var headers = {
      'Authorization': 'Bearer $jwt'
    };
    var request = http.MultipartRequest('POST', Uri.parse(urlBuilder.build()));
    request.fields.addAll({
      "${archive.name.keys.first}[production]": archive.productionID.toString(),
      "${archive.name.keys.first}[broadcast_day]": ESRDateTimeFormatter.formatDateRequests(archive.broadcastDay).toString(),
      "${archive.name.keys.first}[start_time]": ESRDateTimeFormatter.formatMinimalTimeRequests(archive.startTime).toString(),
      "${archive.name.keys.first}[end_time]": ESRDateTimeFormatter.formatMinimalTimeRequests(archive.endTime).toString(),
      "${archive.name.keys.first}[disabled]": archive.disabled ? "1": "0",
      "${archive.name.keys.first}[duration]": archive.audioFileDuration.toString(),
    });

    for (var nameEntry in archive.name.entries){
      request.fields.addAll({
        "${nameEntry.key}[name]": nameEntry.value
      });
    }

    for (var descriptionEntry in archive.description.entries){
      request.fields.addAll({
        "${descriptionEntry.key}[description]": descriptionEntry.value
      });
    }

    if (archive.transcript != null){
      for (var transcriptEntry in archive.transcript!.entries){
        request.fields.addAll({
          "${transcriptEntry.key}[transcript]": transcriptEntry.value
        });
      }
    }

    if (archive.imageBanner != null && archive.imageBanner.toString().isNotEmpty){
      if (io.File(archive.imageBanner.toString()).existsSync()){
        request.files.add(
            await http.MultipartFile.fromPath('en[banner]', archive.imageBanner.toString())
        );
      }
    }

    if (archive.audioFile.toString().isEmpty || !io.File(archive.audioFile.toString()).existsSync()){
      throw InformationNotValidException("Audio File not found");
    }

    request.files.add(
        await http.MultipartFile.fromPath('en[mp3_file]', archive.audioFile.toString())
    );

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRArchivesAddResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRArchivesForYouResults> getUserSuggestionsArchives(
    String jwt,
    {
      int? page,
      int? limit,
      ESRLang? language
    }
  ) async {
    if (jwt.isEmpty){
      throw InformationNotValidException("JWT is not Valid");
    }

    Map<String, dynamic> userDetails;
    try {
      userDetails = JwtDecoder.decode(jwt);
    } on FormatException {
      throw InformationNotValidException("JWT is not Valid");
    }

    final urlBuilder = UrlBuilder('$_apiURL/users/ai/archive-suggestions/${userDetails['user']['id']}');

    if (page != null){
      urlBuilder.addQueryParam("page", page.toString());
    }

    if (limit != null){
      urlBuilder.addQueryParam("limit", limit.toString());
    }

    if (language == null){
      urlBuilder.addQueryParam("lang", "en");
    } else {
      urlBuilder.addQueryParam("lang", language.flag);
    }

    var headers = {
      'Authorization': 'Bearer $jwt'
    };
    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRArchivesForYouResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRArchivesCountryPopularResults> getCountryPopularArchives({
    int? page,
    int? limit,
    ESRLang? language
  }) async {
    final urlBuilder = UrlBuilder('$_apiURL/archives/ai/country-popular');

    if (page != null){
      urlBuilder.addQueryParam("page", page.toString());
    }

    if (limit != null){
      urlBuilder.addQueryParam("limit", limit.toString());
    }

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
      return ESRArchivesCountryPopularResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRArchivesSimilarResults> getSimilarArchivesForArchiveId(int id, {
    ESRLang? language,
    int? maxResults
  }) async {
    final urlBuilder = UrlBuilder('$_apiURL/archives/ai/similar/$id');

    if (language == null){
      urlBuilder.addQueryParam("lang", "en");
    } else {
      urlBuilder.addQueryParam("lang", language.flag);
    }

    if (maxResults != null){
      urlBuilder.addQueryParam("max_results", maxResults.toString());
    }

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRArchivesSimilarResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRArchivesMultipleResults> getMultipleArchives(List<int> ids, {
    ESRLang? language
  }) async {
    final urlBuilder = UrlBuilder('$_apiURL/archives/getMultiple/${ids.join(",")}');

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
      return ESRArchivesMultipleResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}