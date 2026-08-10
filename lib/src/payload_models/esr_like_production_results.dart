import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRLikeProductionCheckLikedProductionResults {
  String status = "";
  bool userLikedProduction = false;
  ESRLikeProduction? likeProductionDetails;

  ESRLikeProductionCheckLikedProductionResults({
    required this.status,
    required this.userLikedProduction,
    this.likeProductionDetails
  });

  factory ESRLikeProductionCheckLikedProductionResults.fromJson(Map<String, dynamic> json){
    return ESRLikeProductionCheckLikedProductionResults(
      status: json['status'],
      userLikedProduction: json['user_liked_production'],
      likeProductionDetails: (json['like_production_details'] == null) ? null : ESRLikeProduction.fromJson(json['like_production_details'])
    );
  }
}

class ESRLikeProductionAddResults {
  String status = "";
  String message = "";
  ESRLikeProduction? likeProduction;

  ESRLikeProductionAddResults({
    required this.status,
    required this.message,
    required this.likeProduction
  });

  factory ESRLikeProductionAddResults.fromJson(Map<String, dynamic> json){
    return ESRLikeProductionAddResults(
      status: json['status'],
      message: json['message'],
      likeProduction: ESRLikeProduction.fromJson(json['like_production'])
    );
  }
}