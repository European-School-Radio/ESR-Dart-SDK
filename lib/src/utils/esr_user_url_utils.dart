import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';

class ESRUserUrlUtils {
  static String getBannerURL(int userID){
    return "${ESRServerConfig.communityBaseUrl}/wp-json/custom/get/user/banner/$userID";
  }
}