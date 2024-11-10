import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/datetime_formatter.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRReservationsService {
  String _apiURL = "";

  ESRReservationsService(){
    _apiURL = ESRServerConfig.apiUrl;
  }

  Future<ESRReservationsMinMaxDatesResults> getMinMaxDates() async {
    var request = http.Request('GET', Uri.parse('$_apiURL/reservations/minMaxDates'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRReservationsMinMaxDatesResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRReservationsByDateResults> getReservationsOnDate(DateTime searchDate, {ESRLang? language}) async {
    final urlBuilder = UrlBuilder('$_apiURL/reservations/byDate');
    urlBuilder.addQueryParam("search_date", ESRDateTimeFormatter.formatDateRequests(searchDate));

    if (language == null){
      urlBuilder.addQueryParam("lang", "en");
    } else {
      urlBuilder.addQueryParam("lang", language.flag);
    }

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRReservationsByDateResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}