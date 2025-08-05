import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/directions/esr_sorting_directions.dart';
import 'package:esr_dart_sdk/src/enums/sorting/esr_lang_sorting.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRProductionSubjectsService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRProductionSubjectsService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRProductionSubjectAddResult> addProductionSubject(ESRAddProductionSubject productionSubject, String jwt) async {
    final urlBuilder = UrlBuilder('$_apiURL/production-subject/add');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $jwt'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'subject': productionSubject.subjectID.toString(),
      'production': productionSubject.productionID.toString()
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRProductionSubjectAddResult.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}