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