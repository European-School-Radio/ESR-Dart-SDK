import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRFollowUsersPaginatedResults {
  int count = 0;
  List<ESRFollowUser>? followUsers;

  ESRFollowUsersPaginatedResults({
    required this.count,
    required this.followUsers
  });

  factory ESRFollowUsersPaginatedResults.fromJson(Map<String, dynamic> json){
    List<dynamic> followUsersList = json['data'] as List<dynamic>;
    List<ESRFollowUser> serializedUserFollows = [];

    serializedUserFollows = followUsersList
        .map((singleFollowUser) => ESRFollowUser.fromJson(singleFollowUser as Map<String, dynamic>))
        .toList();

    return ESRFollowUsersPaginatedResults(
        count: json['count'] ?? 0,
        followUsers: serializedUserFollows
    );
  }
}

class ESRFollowUserCheckFollowedUserResults {
  String status = "";
  bool userFollowedUser = false;
  ESRFollowUser? followUserDetails;

  ESRFollowUserCheckFollowedUserResults({
    required this.status,
    required this.userFollowedUser,
    required this.followUserDetails
  });

  factory ESRFollowUserCheckFollowedUserResults.fromJson(Map<String, dynamic> json){
    return ESRFollowUserCheckFollowedUserResults(
        status: json['status'],
        userFollowedUser: json['user_followed_user_to'],
        followUserDetails: (json['follow_user_to_details'] == null) ? null : ESRFollowUser.fromJson(json['follow_user_to_details'])
    );
  }
}

class ESRFollowUserAddResults {
  String status = "";
  String message = "";
  ESRFollowUser? followUser;

  ESRFollowUserAddResults({
    required this.status,
    required this.message,
    required this.followUser
  });

  factory ESRFollowUserAddResults.fromJson(Map<String, dynamic> json){
    return ESRFollowUserAddResults(
        status: json['status'],
        message: json['message'],
        followUser: ESRFollowUser.fromJson(json['follow_user'])
    );
  }
}

class ESRFollowUserDeleteResults {
  String status = "";
  String message = "";

  ESRFollowUserDeleteResults({
    required this.status,
    required this.message
  });

  factory ESRFollowUserDeleteResults.fromJson(Map<String, dynamic> json){
    return ESRFollowUserDeleteResults(
        status: json['status'],
        message: json['message']
    );
  }
}