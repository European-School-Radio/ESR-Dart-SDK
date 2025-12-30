import 'package:esr_dart_sdk/esr_dart_sdk.dart';
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
    String baseURL = "";
    if (sdk.env == ESREnvironments.test){
      baseURL = ESRServerConfig.webBaseTestUrl;
    } else {
      baseURL = ESRServerConfig.webBaseUrl;
    }

    return "$baseURL/player";
  }
}