import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/esr_environments.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';

class ESRUserUrlUtils {
  static final sdk = ESRSDK();

  static String getBannerURL(int userID){
    return "${ESRServerConfig.communityBaseUrl}/wp-json/custom/get/user/banner/$userID";
  }

  static String getWebURL(int userID, {ESRLang? language}){
    String lang = "en";
    if (language != null){
      lang = language.flag;
    }

    return "${sdk.env.value}/$lang/user/$userID";
  }
}