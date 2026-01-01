import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/esr_environments.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';

class ESRJazlerUrlUtils {
  static final sdk = ESRSDK();

  static String getCurrentAlbumImageURL(){
    String baseURL = "";
    if (sdk.env == ESREnvironments.test){
      baseURL = ESRServerConfig.apiTestUrl;
    } else {
      baseURL = ESRServerConfig.apiUrl;
    }

    return "$baseURL/jazler/get-current-album-image";
  }

  static String getLiveRadioPlayerURL(){

    return "${sdk.env.value}/player";
  }
}