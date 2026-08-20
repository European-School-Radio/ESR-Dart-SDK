import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRFollowPlaylistsService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRFollowPlaylistsService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRFollowPlaylistCheckFollowedPlaylistResults> checkUserFollowedPlaylist(int userID, int playlistID, String jwt) async {
    if (userID == 0 || playlistID == 0 || jwt.isEmpty){
      throw InformationNotValidException("Information not valid");
    }

    final urlBuilder = UrlBuilder('$_apiURL/follow-playlist/userFollowedPlaylist');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $jwt'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      "user_id": userID.toString(),
      "playlist_id": playlistID.toString()
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRFollowPlaylistCheckFollowedPlaylistResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRFollowPlaylistAddResults> addFollowPlaylist(int userID, int playlistID, String jwt) async {
    if (userID == 0 || playlistID == 0 || jwt.isEmpty){
      throw InformationNotValidException("Information not valid");
    }

    final urlBuilder = UrlBuilder('$_apiURL/follow-playlist/add');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $jwt'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      "user": userID.toString(),
      "playlist": playlistID.toString()
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRFollowPlaylistAddResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRFollowPlaylistDeleteResults> removeFollowPlaylist(int likePlaylistID, String jwt) async {
    if (likePlaylistID == 0 || jwt.isEmpty){
      throw InformationNotValidException("Information not valid");
    }

    final urlBuilder = UrlBuilder('$_apiURL/follow-playlist/delete/$likePlaylistID');

    var headers = {
      'Authorization': 'Bearer $jwt'
    };
    var request = http.Request('DELETE', Uri.parse(urlBuilder.build()));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRFollowPlaylistDeleteResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}