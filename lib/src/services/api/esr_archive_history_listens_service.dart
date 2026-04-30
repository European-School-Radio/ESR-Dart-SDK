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
  //   TODO: Add this code
  }
}