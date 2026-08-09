import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';

class ESRUserDevice {
  int id = 0;
  String deviceToken = "";
  ESRUser? user;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRUserDevice({
    required this.id,
    required this.deviceToken,
    this.user,
    required this.created,
    required this.updated
  });
  
  factory ESRUserDevice.fromJson(Map<String, dynamic> json){
    return ESRUserDevice(
      id: json['id'],
      deviceToken: json['device_token'],
      user: IsNumericUtils.isNumeric(json['user'].toString()) ? null : ESRUser.fromJson(json['user']),
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated'])
    );
  }
}

class ESRUserDeviceAdd {
  String deviceToken = "";
  int userID = 0;

  ESRUserDeviceAdd({
    required this.deviceToken,
    required this.userID
  });
}