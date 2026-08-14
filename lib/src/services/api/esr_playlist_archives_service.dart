import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRPlaylistArchivesService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRPlaylistArchivesService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRPlaylistArchivesCheckExistsInPlaylist> checkArchiveExistsInPlaylist(int playlistID, int archiveID, String jwt) async {
    final urlBuilder = UrlBuilder('$_apiURL/playlist-archive/existsInPlaylist');
    urlBuilder.addQueryParam("only_public", "0");
    urlBuilder.addQueryParam("archive_id", archiveID.toString());
    urlBuilder.addQueryParam("playlist_id", playlistID.toString());

    var headers = {
      'Authorization': 'Bearer $jwt'
    };

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRPlaylistArchivesCheckExistsInPlaylist.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRPlaylistArchivesAddArchiveToPlaylistResult> addArchiveToPlaylist(int playlistID, int archiveID, String jwt) async {
    final urlBuilder = UrlBuilder('$_apiURL/playlist-archive/add');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $jwt'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'playlist': playlistID.toString(),
      'archive': archiveID.toString()
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRPlaylistArchivesAddArchiveToPlaylistResult.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}