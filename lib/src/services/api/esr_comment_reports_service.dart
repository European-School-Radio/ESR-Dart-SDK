import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRCommentReportsService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRCommentReportsService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRCommentReportsAddResult> addCommentReport(int commentID, int userID, int reportReasonID, String description, String jwt) async {
    final urlBuilder = UrlBuilder('$_apiURL/comment-report/add');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $jwt'
    };

    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      "comment": commentID.toString(),
      "report_reason": reportReasonID.toString(),
      "user": userID.toString(),
      "description": description
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRCommentReportsAddResult.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}