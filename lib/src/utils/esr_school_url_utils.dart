import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';

class ESRSchoolUrlUtils {
  static final sdk = ESRSDK();

  static String getBannerURL(int schoolID, {ESRLang? language}){
    String lang = "en";
    if (language != null){
      lang = language.flag;
    }

    String baseURL = "";
    if (sdk.env == ESREnvironments.test){
      baseURL = ESRServerConfig.apiTestUrl;
    } else {
      baseURL = ESRServerConfig.apiUrl;
    }

    return "$baseURL/school/getBanner/$schoolID?lang=$lang";
  }

  static String getSpotURL(int schoolID, {ESRLang? language}){
    String lang = "en";
    if (language != null){
      lang = language.flag;
    }

    String baseURL = "";
    if (sdk.env == ESREnvironments.test){
      baseURL = ESRServerConfig.apiTestUrl;
    } else {
      baseURL = ESRServerConfig.apiUrl;
    }

    return "$baseURL/school/getSpot/$schoolID?lang=$lang";
  }
}