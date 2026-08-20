import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRArchiveReportsService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRArchiveReportsService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRArchiveReportsAddResult> addArchiveReport(int archiveID, int userID, int reportReasonID, String description, String jwt) async {
    if (archiveID == 0 || userID == 0 || reportReasonID == 0 || jwt.isEmpty){
      throw InformationNotValidException("Information not valid");
    }

    final urlBuilder = UrlBuilder('$_apiURL/archive-report/add');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $jwt'
    };

    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      "archive": archiveID.toString(),
      "report_reason": reportReasonID.toString(),
      "user": userID.toString(),
      "description": description.isEmpty ? "" : description
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRArchiveReportsAddResult.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}