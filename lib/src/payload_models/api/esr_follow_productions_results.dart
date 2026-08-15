import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRFollowProductionsPaginatedResults {
  int count = 0;
  List<ESRFollowProduction>? followProductions;

  ESRFollowProductionsPaginatedResults({
    required this.count,
    required this.followProductions
  });

  factory ESRFollowProductionsPaginatedResults.fromJson(Map<String, dynamic> json){
    List<dynamic> followProductionsList = json['data'] as List<dynamic>;
    List<ESRFollowProduction> serializedProductionsFollows = [];

    serializedProductionsFollows = followProductionsList
        .map((singleFollowProduction) => ESRFollowProduction.fromJson(singleFollowProduction as Map<String, dynamic>))
        .toList();

    return ESRFollowProductionsPaginatedResults(
        count: json['count'] ?? 0,
        followProductions: serializedProductionsFollows
    );
  }
}

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