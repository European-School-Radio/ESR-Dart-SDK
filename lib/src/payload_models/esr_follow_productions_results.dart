import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRFollowProductionCheckFollowedProductionResults {
  String status = "";
  bool userFollowedProduction = false;
  ESRFollowProduction? followProductionDetails;

  ESRFollowProductionCheckFollowedProductionResults({
    required this.status,
    required this.userFollowedProduction,
    required this.followProductionDetails
  });

  factory ESRFollowProductionCheckFollowedProductionResults.fromJson(Map<String, dynamic> json){
    return ESRFollowProductionCheckFollowedProductionResults(
      status: json['status'],
      userFollowedProduction: json['user_followed_production'],
      followProductionDetails: (json['follow_production_details'] == null) ? null : ESRFollowProduction.fromJson(json['follow_production_details'])
    );
  }
}

class ESRFollowProductionAddResults {
  String status = "";
  String message = "";
  ESRFollowProduction? followProduction;

  ESRFollowProductionAddResults({
    required this.status,
    required this.message,
    required this.followProduction
  });

  factory ESRFollowProductionAddResults.fromJson(Map<String, dynamic> json){
    return ESRFollowProductionAddResults(
      status: json['status'],
      message: json['message'],
      followProduction: ESRFollowProduction.fromJson(json['follow_production'])
    );
  }
}

class ESRFollowProductionDeleteResults {
  String status = "";
  String message = "";

  ESRFollowProductionDeleteResults({
    required this.status,
    required this.message
  });

  factory ESRFollowProductionDeleteResults.fromJson(Map<String, dynamic> json){
    return ESRFollowProductionDeleteResults(
      status: json['status'],
      message: json['message']
    );
  }
}