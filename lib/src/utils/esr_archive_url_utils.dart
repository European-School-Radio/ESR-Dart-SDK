import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/esr_environments.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';

class ESRArchiveUrlUtils {
  static final sdk = ESRSDK();

  static String getBannerURL(int archiveID, {ESRLang? language}){
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

    return "$baseURL/archive/getBanner/$archiveID?lang=$lang&request_application=${sdk.env.requestApplication}";
  }

  static String getAudioURL(int archiveID, {ESRLang? language}){
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

    return "$baseURL/archive/getEpisode/$archiveID?lang=$lang";
  }

  static String getWebURL(int archiveID, {ESRLang? language}){
    String lang = "en";
    if (language != null){
      lang = language.flag;
    }

    return "${sdk.env.value}/$lang/episode/$archiveID";
  }
}