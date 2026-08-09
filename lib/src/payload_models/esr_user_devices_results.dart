import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRUserDeviceAddResult {
  String status = "";
  String message = "";
  ESRUserDevice? userDevice;

  ESRUserDeviceAddResult({
    required this.status,
    required this.message,
    required this.userDevice
  });
  
  factory ESRUserDeviceAddResult.fromJson(Map<String, dynamic> json){
   return ESRUserDeviceAddResult(
     status: json['status'],
     message: json['message'],
     userDevice: ESRUserDevice.fromJson(json['user_device'])
   ); 
  }
}