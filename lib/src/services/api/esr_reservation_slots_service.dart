import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/datetime_formatter.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRReservationSlotsService {
  String _apiURL = "";

  ESRReservationSlotsService(){
    _apiURL = ESRServerConfig.apiUrl;
  }

  Future<ESRReservationSlotsByDateResults> getReservationsOnDate(DateTime searchDate, {ESRLang? language}) async {
    final urlBuilder = UrlBuilder('$_apiURL/reservation-slot/getByRange');
    urlBuilder.addQueryParam("start_date", ESRDateTimeFormatter.formatDateRequests(searchDate));
    urlBuilder.addQueryParam("end_date", ESRDateTimeFormatter.formatDateRequests(searchDate));

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
      return ESRReservationSlotsByDateResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}