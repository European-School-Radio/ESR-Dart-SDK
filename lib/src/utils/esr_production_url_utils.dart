import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';

class ESRProductionUrlUtils {
  static final sdk = ESRSDK();

  static String getBannerURL(int productionID, {ESRLang? language}){
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

    return "$baseURL/production/getBanner/$productionID?lang=$lang";
  }

  static String getSpotURL(int productionID, {ESRLang? language}){
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

    return "$baseURL/production/getSpot/$productionID?lang=$lang";
  }

  static String getVideoBannerURL(int productionID, {ESRLang? language}){
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

    return "$baseURL/production/getVideo/$productionID?lang=$lang";
  }

  static String getWebURL(int productionID, {ESRLang? language}){
    String lang = "en";
    if (language != null){
      lang = language.flag;
    }

    String baseURL = "";
    if (sdk.env == ESREnvironments.test){
      baseURL = ESRServerConfig.webBaseTestUrl;
    } else if (sdk.env == ESREnvironments.production){
      baseURL = ESRServerConfig.webBaseUrl;
    } else if (sdk.env == ESREnvironments.youthRadio){
      baseURL = ESRServerConfig.webBaseYouthUrl;
    } else {
      baseURL = ESRServerConfig.webBaseUrl;
    }

    return "$baseURL/$lang/podcast/$productionID";
  }
}