import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRArchiveHistoryListensService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRArchiveHistoryListensService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRArchiveHistoryListensAddResults> addArchiveHistoryListen(ESRAddArchiveHistoryListen archiveHistoryListen) async {
    final urlBuilder = UrlBuilder('$_apiURL/archive-history-listen/add');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      "archive": archiveHistoryListen.archiveID.toString(),
      "total_time": archiveHistoryListen.totalTime.toString()
    };
    if (archiveHistoryListen.userID != null){
      request.bodyFields.addAll({
        "user": archiveHistoryListen.userID.toString()
      });
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201){
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRArchiveHistoryListensAddResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRArchiveHistoryListensUpdateResults> updateArchiveHistoryListen(int id, ESRAddArchiveHistoryListen archiveHistoryListen) async {
    final urlBuilder = UrlBuilder("$_apiURL/archive-history-listen/edit/$id");

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('PUT', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      "archive": archiveHistoryListen.archiveID.toString(),
      "total_time": archiveHistoryListen.totalTime.toString()
    };
    if (archiveHistoryListen.userID != null){
      request.bodyFields.addAll({
        "user": archiveHistoryListen.userID.toString()
      });
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200){
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRArchiveHistoryListensUpdateResults.fromJson(jsonData);
    } else if (response.statusCode == 404){
      throw ObjectNotFoundException("Archive History Listen with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}