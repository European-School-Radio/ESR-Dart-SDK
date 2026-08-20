import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRArchiveSubjectsService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRArchiveSubjectsService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRArchiveSubjectsAddResult> addArchiveSubject(ESRAddArchiveSubject archiveSubject, String jwt) async {
    if (archiveSubject.subjectID == 0 || archiveSubject.archiveID == 0 || jwt.isEmpty) {
      throw InformationNotValidException("Information not valid");
    }

    final urlBuilder = UrlBuilder('$_apiURL/archive-subject/add');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $jwt'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'subject': archiveSubject.subjectID.toString(),
      'archive': archiveSubject.archiveID.toString()
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRArchiveSubjectsAddResult.fromJson(jsonData);
    } else if (response.statusCode == 401){
      throw UnAuthorizedException("Authentication not valid");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}