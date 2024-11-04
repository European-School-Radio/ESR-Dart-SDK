import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRUser {
  int id = 0;
  String firstName = "";
  String lastName = "";
  String? nativeFirstName;
  String? nativeLastName;
  String username = "";
  String? password;
  String email = "";
  String? phone;
  String position = "";
  ESRRole role;
  ESRSector sector;
  bool isBlocked = false;
  String timeZone = "";
  ESRCountry country;
  bool schoolsChecked = false;
  int followCount = 0;
  int followingCount = 0;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.nativeFirstName,
    this.nativeLastName,
    required this.username,
    this.password,
    required this.email,
    this.phone,
    required this.position,
    required this.role,
    required this.sector,
    required this.isBlocked,
    required this.timeZone,
    required this.country,
    required this.schoolsChecked,
    required this.followCount,
    required this.followingCount,
    required this.created,
    required this.updated
  });

  factory ESRUser.fromJson(Map<String, dynamic> json){
    return ESRUser(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        username: json['username'],
        password: null,
        email: json['email'],
        position: json['position'],
        role: ESRRole.fromJson(json['role']),
        sector: ESRSector.fromJson(json['sector']),
        isBlocked: json['is_blocked'],
        timeZone: json['time_zone'],
        country: ESRCountry.fromJson(json['country']),
        schoolsChecked: json['schools_checked'],
        followCount: json['follow_count'],
        followingCount: json['following_count'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated']),
    );
  }
}