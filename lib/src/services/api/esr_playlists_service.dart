import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRPlaylistsService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRPlaylistsService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRPlaylist> getPlaylistById(int id, {ESRLang? language}) async {
    final urlBuilder = UrlBuilder('$_apiURL/playlist/$id');

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
      return ESRPlaylist.fromJson(jsonData['playlist']);
    } else if (response.statusCode == 404){
      throw ObjectNotFoundException("Playlist with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRPlaylistsIncreaseSharesCounterResults> increaseSharesCount(int id) async {
    final urlBuilder = UrlBuilder('$_apiURL/playlist/share/$id');

    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRPlaylistsIncreaseSharesCounterResults.fromJson(jsonData);
    } else if (response.statusCode == 404){
      throw ObjectNotFoundException("Playlist with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}