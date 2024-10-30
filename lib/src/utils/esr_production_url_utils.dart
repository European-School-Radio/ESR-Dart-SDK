import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';

class ESRProductionUrlUtils {
  static String getBannerURL(int productionID, [ESRLang? language]){
    String lang = "en";
    if (language != null){
      lang = language.flag;
    }

    return "${ESRServerConfig.apiUrl}/getBanner/$productionID?lang=$lang";
  }

  static String getSpotURL(int productionID, [ESRLang? language]){
    String lang = "en";
    if (language != null){
      lang = language.flag;
    }

    return "${ESRServerConfig.apiUrl}/getSpot/$productionID?lang=$lang";
  }

  static String getVideoBannerURL(int productionID, [ESRLang? language]){
    String lang = "en";
    if (language != null){
      lang = language.flag;
    }

    return "${ESRServerConfig.apiUrl}/getVideo/$productionID?lang=$lang";
  }
}