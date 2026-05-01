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