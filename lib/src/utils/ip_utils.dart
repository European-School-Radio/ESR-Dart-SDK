import 'dart:convert';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRIPUtils {
  static Future<String> getIP() async {
    final urlBuilder = UrlBuilder('https://api.ipify.org');

    urlBuilder.addQueryParam("format", "json");

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return jsonData['ip'];
    } else {
      return "127.0.0.1";
    }
  }
}