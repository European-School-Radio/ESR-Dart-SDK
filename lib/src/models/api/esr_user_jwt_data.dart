import 'package:jwt_decoder/jwt_decoder.dart';

class ESRUserJwtData {
  String token;
  int? userID;
  String? firstName;
  String? lastName;
  String? nativeFirstName;
  String? nativeLastName;

  ESRUserJwtData(
      {required this.token,
      this.userID,
      this.firstName,
      this.lastName,
      this.nativeFirstName,
      this.nativeLastName});

  factory ESRUserJwtData.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(json["token"]);

    return ESRUserJwtData(
        token: json["token"],
        userID: int.parse(decodedToken["user"]["id"].toString()),
        firstName: decodedToken["user"]["first_name"],
        lastName: decodedToken["user"]["last_name"],
        nativeFirstName: decodedToken["user"]["native_first_name"],
        nativeLastName: decodedToken["user"]["native_last_name"]);
  }
}
