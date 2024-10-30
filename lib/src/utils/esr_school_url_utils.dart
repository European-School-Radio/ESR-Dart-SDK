import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';

class ESRSchoolUrlUtils {
  static String getBannerURL(int schoolID, [ESRLang? language]){
    String lang = "en";
    if (language != null){
      lang = language.flag;
    }

    return "${ESRServerConfig.apiUrl}/school/getBanner/$schoolID?lang=$lang";
  }

  static String getSpotURL(int schoolID, [ESRLang? language]){
    String lang = "en";
    if (language != null){
      lang = language.flag;
    }

    return "${ESRServerConfig.apiUrl}/school/getSpot/$schoolID?lang=$lang";
  }
}