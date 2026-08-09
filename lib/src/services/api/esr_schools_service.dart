import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/directions/esr_sorting_directions.dart';
import 'package:esr_dart_sdk/src/enums/esr_environments.dart';
import 'package:esr_dart_sdk/src/enums/sorting/esr_school_sorting.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/ip_utils.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRSchoolsService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRSchoolsService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRSchoolsPaginatedResults> getAllSchools({
    int? page,
    int? limit,
    ESRSchoolSorting? sorting,
    ESRSortingDirections? direction
  }) async {
    final urlBuilder = UrlBuilder('$_apiURL/schools');

    if (page != null){
      urlBuilder.addQueryParam("page", page.toString());
    }

    if (limit != null){
      urlBuilder.addQueryParam("limit", limit.toString());
    }

    if (sorting != null){
      urlBuilder.addQueryParam("sort", sorting.value.toString());
    }

    if (direction != null){
      urlBuilder.addQueryParam("direction", direction.value.toString());
    }

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRSchoolsPaginatedResults.fromJson(jsonData, limit);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRSchool> getSchoolById(int id, {ESRLang? language, String? userJWT}) async {
    final urlBuilder = UrlBuilder('$_apiURL/school/$id');

    if (language == null){
      urlBuilder.addQueryParam("lang", "en");
    } else {
      urlBuilder.addQueryParam("lang", language.flag);
    }

    Map<String, String> allHeaders = {};

    String userIP = await ESRIPUtils.getIP();
    allHeaders['X-User-IP'] = userIP;
    allHeaders['User-Agent'] = "${sdk.env.fullNameApplication} Application/${sdk.appVersion} (Dart SDK/${sdk.sdkVersion})";
    allHeaders['Authorization'] = (userJWT == null) ? "" : "Bearer $userJWT";
    allHeaders['X-App-Source-URL'] = sdk.env.sourceApplicationURL.toString();

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    request.headers.addAll(allHeaders);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRSchool.fromJson(jsonData['school']);
    } else if (response.statusCode == 404){
      throw ObjectNotFoundException("School with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRSchoolAddResults> addSchool(ESRAddSchool schoolAdd, String jwt) async {
    if (schoolAdd.name.isEmpty || schoolAdd.nativeName.isEmpty || schoolAdd.description.isEmpty || schoolAdd.nativeDescription.isEmpty || schoolAdd.city.isEmpty || schoolAdd.address.isEmpty || schoolAdd.zipCode.isEmpty || schoolAdd.latitude == 0.0 || schoolAdd.longitude == 0.0 || schoolAdd.officialNumber.isEmpty || schoolAdd.email.isEmpty || schoolAdd.phone.isEmpty){
      throw InformationNotValidException("You have to send valid values for name, description, native name, native description, city, address, zip code, latitude, longitude, official number, email and phone");
    }
    if (!EmailValidator.validate(schoolAdd.email)){
      throw InformationNotValidException("Email has not a valid format");
    }
    
    final urlBuilder = UrlBuilder("$_apiURL/school/add");

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $jwt'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));

    Map<String, String> bodyFields = {};

    bodyFields = {
      'en[name]': schoolAdd.name,
      'en[native_name]': schoolAdd.nativeName,
      'en[description]': schoolAdd.description,
      'en[native_description]': schoolAdd.nativeDescription,
      'en[school_type]': schoolAdd.schoolType.id.toString(),
      'en[country]': schoolAdd.country.id.toString(),
      'en[city]': schoolAdd.city,
      'en[address]': schoolAdd.address,
      'en[zip_code]': schoolAdd.zipCode,
      'en[latitude]': schoolAdd.latitude.toString(),
      'en[longitude]': schoolAdd.longitude.toString(),
      'en[official_number]': schoolAdd.officialNumber,
      'en[email]': schoolAdd.email,
      'en[phone]': schoolAdd.phone,
      'en[source_platform]': sdk.env.requestApplication.toString(),
      'en[disabled]': schoolAdd.disabled ? "1" : "0"
    };

    request.bodyFields = bodyFields;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRSchoolAddResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRSchoolsMinimalDataResults> getSchoolsMinimalData() async {
    final urlBuilder = UrlBuilder('$_apiURL/schools/minimal-data');

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRSchoolsMinimalDataResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRSchoolsIncreaseSharesCounterResults> increaseSharesCount(int id) async {
    final urlBuilder = UrlBuilder('$_apiURL/school/share/$id');

    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRSchoolsIncreaseSharesCounterResults.fromJson(jsonData);
    } else if (response.statusCode == 404){
      throw ObjectNotFoundException("Archive with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}