import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRFollowUser {
  int id = 0;
  ESRUser? user;
  ESRUser? userTo;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRFollowUser({
    required this.id,
    required this.user,
    required this.userTo,
    required this.created,
    required this.updated,
  });

  factory ESRFollowUser.fromJson(Map<String, dynamic> json){
    return ESRFollowUser(
      id: json['id'],
      user: ESRUser.fromJson(json['user']),
      userTo: ESRUser.fromJson(json['user_to']),
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated'])
    );
  }
}