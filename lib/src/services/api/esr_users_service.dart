import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/esr_environments.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ESRUsersService {
  final sdk = ESRSDK();
  String _apiURL = "";
  String _communityApiURL = ESRServerConfig.communityBaseUrl;

  ESRUsersService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRUsersLoginResults> loginUsername(String username, String password) async {
    final urlBuilder = UrlBuilder('$_apiURL/users/login');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'username': username,
      'password': password,
      'request_application': sdk.env == ESREnvironments.youthRadio ? "YouthRadio" : "European_School_Radio"
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUsersLoginResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRUsersLoginResults> loginEmail(String email, String password) async {
    if (!EmailValidator.validate(email)){
      throw InformationNotValidException("Email Address is not valid");
    }

    final urlBuilder = UrlBuilder('$_apiURL/users/login-email');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'email': email,
      'password': password,
      'request_application': sdk.env == ESREnvironments.youthRadio ? "Youth_Radio" : "European_School_Radio"
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUsersLoginResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRUsersLoginResults> loginExternalSSO(String username, String password) async {
    final urlBuilder = UrlBuilder('$_apiURL/users/login-external-sso');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'username': username,
      'password': password,
      'sso_api_key': sdk.ssoApiKey,
      'request_application': sdk.env == ESREnvironments.youthRadio ? "Youth_Radio" : "European_School_Radio"
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUsersLoginResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRUsersRequestResetPasswordResults> forgotPasswordRequest(String usernameEmail) async {
    final urlBuilder = UrlBuilder('$_apiURL/user/reset-password-request');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    if (EmailValidator.validate(usernameEmail)){
      request.bodyFields = {
        'email': usernameEmail
      };
    } else {
      request.bodyFields = {
        'username': usernameEmail
      };
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUsersRequestResetPasswordResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRUsersCheckResetTokenValidityResults> checkResetTokenValidityRequest(String userToken, int userID) async {
    final urlBuilder = UrlBuilder('$_apiURL/user/check-reset-token-validity');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'token': userToken,
      'user_id': userID.toString()
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUsersCheckResetTokenValidityResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRUsersCancelResetTokenResults> cancelResetPasswordToken(String userToken, int userID) async {
    final urlBuilder = UrlBuilder('$_apiURL/user/cancel-reset-token-request');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'token': userToken,
      'user_id': userID.toString()
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUsersCancelResetTokenResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRUsersResetPasswordResults> resetPassword(String password, String userToken, int userID) async {
    if (!password.contains(RegExp(r'[^\w\s]'))){
      throw InformationNotValidException("Password must contain at least one special character");
    }
    if (!password.contains(RegExp(r'[A-Z]'))){
      throw InformationNotValidException("Password must contain at least one capital letter");
    }
    if (!password.contains(RegExp(r'[a-z]'))){
      throw InformationNotValidException("Password must contain at least on lower letter");
    }
    if (password.length < 12){
      throw InformationNotValidException("Password must be at least 12 characters long");
    }
    
    final urlBuilder = UrlBuilder('$_apiURL/user/reset-password/$userID');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'token': userToken,
      'password': password
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUsersResetPasswordResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRUsersLoginResults> registerUser(ESRUserAdd userAdd) async {
    if (userAdd.firstName == null || userAdd.lastName == null || userAdd.nativeFirstName == null || userAdd.nativeLastName == null || userAdd.roleID == null || userAdd.sectorID == null || userAdd.username == null || userAdd.password == null || userAdd.email == null || userAdd.position == null || userAdd.countryID == null){
      throw InformationNotValidException("You have to send valid values for username, email, password, first name and last name");
    }
    if (userAdd.firstName!.isEmpty || userAdd.lastName!.isEmpty || userAdd.nativeFirstName!.isEmpty || userAdd.nativeLastName!.isEmpty || userAdd.roleID == 0 || userAdd.sectorID == 0 || userAdd.username!.isEmpty || userAdd.password!.isEmpty || userAdd.email!.isEmpty || userAdd.position!.isEmpty || userAdd.countryID == 0){
      throw InformationNotValidException("You have to send valid values for username, email, password, first name and last name");
    }
    if (!EmailValidator.validate(userAdd.email!)){
      throw InformationNotValidException("Email has not a valid format");
    }

    final urlBuilder = UrlBuilder('$_apiURL/user/add');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'first_name': userAdd.firstName!,
      'last_name': userAdd.lastName!,
      'native_first_name': userAdd.nativeFirstName!,
      'native_last_name': userAdd.nativeLastName!,
      'role': userAdd.roleID.toString(),
      'sector': userAdd.sectorID.toString(),
      'username': userAdd.username!,
      'password': userAdd.password!,
      'email': userAdd.email!,
      'position': userAdd.position!,
      'is_blocked': userAdd.isBlocked! ? "1" : "0",
      'country': userAdd.countryID.toString(),
      'send_email': userAdd.sendEmail! ? "1" : "0",
      "source_platform": sdk.env.requestApplication.toString()
    };
    if (userAdd.ssoModel != null && userAdd.ssoModel!.isNotEmpty){
      request.bodyFields.addAll({
        "sso_model": userAdd.ssoModel!
      });
    }
    if (userAdd.phone != null && userAdd.phone!.isNotEmpty){
      request.bodyFields.addAll({
        "phone": userAdd.phone!
      });
    }
    if (userAdd.gender != null){
      request.bodyFields.addAll({
        "gender": userAdd.gender.toString()
      });
    }
    if (userAdd.preferredLang != null){
      request.bodyFields.addAll({
        "preferred_lang": userAdd.preferredLang.toString()
      });
    }
    if (userAdd.birthDate != null){
      String formattedDate = DateFormat('yyyy-MM-dd').format(userAdd.birthDate!);
      request.bodyFields.addAll({
        "birth_date": formattedDate
      });
    }
    if (userAdd.timezone != null){
      request.bodyFields.addAll({
        "time_zone": userAdd.timezone.toString()
      });
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUsersLoginResults.fromJson(jsonData);
    } else if (response.statusCode == 400){
      var responsePlain = await response.stream.bytesToString();
      Map<String, dynamic> jsonData = json.decode(responsePlain);

      if (jsonData.containsKey("email")){
        throw UserAddEmailExistsException("Email exists !");
      }
      if (jsonData.containsKey("username")){
        throw UserAddUsernameExistsException("Username exists !");
      }
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRUsersCommunityRegisterResults> registerUserCommunity(String username, String email, String password, String firstName, String lastName, int userID) async {
    if (username.isEmpty || email.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty){
      throw InformationNotValidException("You have to send valid values for username, email, password, first name and last name");
    }
    if (!EmailValidator.validate(email)){
      throw InformationNotValidException("Email has not a valid format");
    }
    if (sdk.communityApiKey.isEmpty){
      throw InformationNotValidException("You MUST provide community API Key on SDK initialization");
    }

    final urlBuilder = UrlBuilder('$_communityApiURL/wp-json/custom/add/user');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'username': username,
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'SR2_id': userID.toString(),
      'api_key': sdk.communityApiKey
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUsersCommunityRegisterResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRUsersCheckUsernameResults> checkUsernameExists(String username) async {
    final urlBuilder = UrlBuilder('$_apiURL/user/check-username');
    urlBuilder.addQueryParam("username", username);

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUsersCheckUsernameResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRUsersCheckEmailResults> checkEmailExists(String email) async {
    if (!EmailValidator.validate(email)){
      throw InformationNotValidException("Email has not a valid format");
    }

    final urlBuilder = UrlBuilder('$_apiURL/user/check-email');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'email': email
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUsersCheckEmailResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRUsersVerifyTokenResults> verifyRegistrationToken(String token) async {
    final urlBuilder = UrlBuilder('$_apiURL/users/verifyToken');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'token': token
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUsersVerifyTokenResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRUsersVerifyUserResults> verifyUser(String token, int userID) async {
    final urlBuilder = UrlBuilder('$_apiURL/user/verify/$userID');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'token': token
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUsersVerifyUserResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRUsersEditResults> editUser(ESRUserAdd userAdd, String jwt, int userID) async {
    if (userAdd.email != null && userAdd.email!.isNotEmpty){
      if (!EmailValidator.validate(userAdd.email!)){
        throw InformationNotValidException("Email has not a valid format");
      }
    }

    final urlBuilder = UrlBuilder('$_apiURL/user/edit/$userID');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('PUT', Uri.parse(urlBuilder.build()));
    if (userAdd.firstName != null){
      request.bodyFields.addAll({
        "first_name": userAdd.firstName!
      });
    }
    if (userAdd.lastName != null){
      request.bodyFields.addAll({
        "last_name": userAdd.lastName!
      });
    }
    if (userAdd.nativeFirstName != null){
      request.bodyFields.addAll({
        "native_first_name": userAdd.nativeFirstName!
      });
    }
    if (userAdd.nativeLastName != null){
      request.bodyFields.addAll({
        "native_last_name": userAdd.nativeLastName!
      });
    }
    if (userAdd.roleID != null){
      request.bodyFields.addAll({
        "role": userAdd.roleID.toString()
      });
    }
    if (userAdd.sectorID != null){
      request.bodyFields.addAll({
        "sector": userAdd.sectorID.toString()
      });
    }
    if (userAdd.password != null){
      request.bodyFields.addAll({
        "password": userAdd.password!
      });
    }
    if (userAdd.position != null){
      request.bodyFields.addAll({
        "position": userAdd.position!
      });
    }
    if (userAdd.countryID != null){
      request.bodyFields.addAll({
        "country": userAdd.countryID.toString()
      });
    }
    if (userAdd.ssoModel != null && userAdd.ssoModel!.isNotEmpty){
      request.bodyFields.addAll({
        "sso_model": userAdd.ssoModel!
      });
    }
    if (userAdd.phone != null){
      request.bodyFields.addAll({
        "phone": userAdd.phone!
      });
    }
    if (userAdd.gender != null){
      request.bodyFields.addAll({
        "gender": userAdd.gender.toString()
      });
    }
    if (userAdd.preferredLang != null){
      request.bodyFields.addAll({
        "preferred_lang": userAdd.preferredLang.toString()
      });
    }
    if (userAdd.birthDate != null){
      String formattedDate = DateFormat('yyyy-MM-dd').format(userAdd.birthDate!);
      request.bodyFields.addAll({
        "birth_date": formattedDate
      });
    }
    if (userAdd.timezone != null){
      request.bodyFields.addAll({
        "time_zone": userAdd.timezone.toString()
      });
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUsersEditResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRUsersPublicProfile> getPublicProfileById(int id, {ESRLang? language}) async {
    final urlBuilder = UrlBuilder('$_apiURL/users/publicProfile/$id');

    if (language != null){
      urlBuilder.addQueryParam("lang", language.flag);
    } else {
      urlBuilder.addQueryParam("lang", "en");
    }

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUsersPublicProfile.fromJson(jsonData);
    } else if (response.statusCode == 404) {
      throw ObjectNotFoundException("User with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRUserCoverDataResults> getUserCoverById(int id) async {
    final urlBuilder = UrlBuilder('${ESRServerConfig.communityBaseUrl}/wp-json/custom/get/user/cover/$id');

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUserCoverDataResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRUsersSimilarUsersResults> getSimilarUsersById(int id, {int? maxItems, ESRLang? language}) async {
    final urlBuilder = UrlBuilder('$_apiURL/users/find-similar/$id');

    if (maxItems != null){
      urlBuilder.addQueryParam("max_results", maxItems.toString());
    } else {
      urlBuilder.addQueryParam("max_results", "5");
    }

    if (language != null){
      urlBuilder.addQueryParam("lang", language.flag);
    } else {
      urlBuilder.addQueryParam("lang", "en");
    }

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRUsersSimilarUsersResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}