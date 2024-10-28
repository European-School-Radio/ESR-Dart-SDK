import 'package:esr_dart_sdk/src/models/esr_lang.dart';
import 'package:esr_dart_sdk/src/models/esr_production_type.dart';
import 'package:esr_dart_sdk/src/models/esr_school_year.dart';
import 'package:esr_dart_sdk/src/models/esr_users_school.dart';
import 'package:esr_dart_sdk/src/models/esr_zone.dart';

class ESRProduction {
  int id = 0;
  String name = "";
  String? description;
  String? imageBanner;
  String? videoBanner;
  String? spot;
  ESRSchoolYear schoolYear;
  ESRUsersSchools userSchool;
  ESRProductionType productionType;
  ESRLang lang;
  ESRZone? zone;
  int followCount = 0;
  int likesCount = 0;
  int sharesCount = 0;
  bool disabled = false;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRProduction({
    required this.id,
    required this.name,
    this.description,
    this.imageBanner,
    this.videoBanner,
    this.spot,
    required this.schoolYear,
    required this.userSchool,
    required this.productionType,
    required this.lang,
    this.zone,
    required this.followCount,
    required this.likesCount,
    required this.sharesCount,
    required this.disabled,
    required this.created,
    required this.updated,
  });

  factory ESRProduction.fromJson(Map<String, dynamic> json) {
    return ESRProduction(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageBanner: json['image_banner'],
      videoBanner: json['video_banner'],
      spot: json['spot'],
      schoolYear: ESRSchoolYear.fromJson(json['school_year']),
      userSchool: ESRUsersSchools.fromJson(json['user_school']),
      productionType: ESRProductionType.fromJson(json['production_type']),
      lang: ESRLang.fromJson(json['lang']),
      zone: json['zone'] != null ? ESRZone.fromJson(json['zone']) : null,
      followCount: json['follow_count'] ?? 0,
      likesCount: json['likes_count'] ?? 0,
      sharesCount: json['shares-Count'] ?? 0,
      disabled: json['disabled'] ?? false,
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
    );
  }
}