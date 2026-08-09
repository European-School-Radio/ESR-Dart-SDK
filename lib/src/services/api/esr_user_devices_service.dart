import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/directions/esr_sorting_directions.dart';
import 'package:esr_dart_sdk/src/enums/sorting/esr_subject_sorting.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRUserDevicesService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRUserDevicesService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRUserDeviceAddResult> addUserDevice(ESRUserDeviceAdd userDeviceAdd, String jwt) async {
    final urlBuilder = UrlBuilder("$_apiURL/user-device/add");

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $jwt'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'user': userDeviceAdd.userID.toString(),
      'device_token': userDeviceAdd.deviceToken,
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201 || response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUserDeviceAddResult.fromJson(jsonData);
    } else if (response.statusCode == 401){
      throw UnAuthorizedException("Authentication not valid");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}