import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/esr_environments.dart';

class ESRPlaylistUrlUtils {
  static final sdk = ESRSDK();

  static String getWebURL(int playlistID, {ESRLang? language}){
    String lang = "en";
    if (language != null){
      lang = language.flag;
    }

    return "${sdk.env.value}/$lang/playlist/$playlistID";
  }
}