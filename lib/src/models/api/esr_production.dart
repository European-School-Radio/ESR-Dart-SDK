import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRProduction {
  int id = 0;
  String name = "";
  String? description;
  String? imageBanner;
  String? videoBanner;
  String? spot;
  String? imageBannerAlternativeText;
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
  ESRReservation? reservation;
  List<ESRArchive> archives = [];
  List<ESRProductionSubject> productionSubjects = [];
  List<ESRProductionLanguage> productionSecondaryLanguages = [];
  int translatedLanguagesCount = 0;

  ESRProduction({
    required this.id,
    required this.name,
    this.description,
    this.imageBanner,
    this.videoBanner,
    this.spot,
    this.imageBannerAlternativeText,
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
    required this.reservation,
    required this.archives,
    required this.productionSubjects,
    required this.productionSecondaryLanguages,
    required this.translatedLanguagesCount
  });

  factory ESRProduction.fromJson(Map<String, dynamic> json) {
    List<ESRArchive> serializedArchives = (json['archives'] as List<dynamic>?)
        ?.map((singleArchive) => ESRArchive.fromJson(singleArchive as Map<String, dynamic>))
        .toList()
        ?? [];

    List<ESRProductionSubject> serializedProductionSubjects = (json['production_subjects'] as List<dynamic>?)
        ?.map((singleProductionSubject) => ESRProductionSubject.fromJson(singleProductionSubject as Map<String, dynamic>))
        .toList()
        ?? [];

    List<ESRProductionLanguage> serializedProductionSecondaryLanguages = (json['production_secondary_languages'] as List<dynamic>)
        .map((singleSecondaryLanguage) => ESRProductionLanguage.fromJson(singleSecondaryLanguage as Map<String, dynamic>))
        .toList();

    return ESRProduction(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageBanner: json['image_banner'],
      videoBanner: json['video_banner'],
      spot: json['spot'],
      imageBannerAlternativeText: json["image_banner_alternative_text"],
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
      reservation: json['reservation'] != null ? ESRReservation.fromJson(json['reservation']) : null,
      archives: serializedArchives,
      productionSubjects: serializedProductionSubjects,
      productionSecondaryLanguages: serializedProductionSecondaryLanguages,
      translatedLanguagesCount: json['translated_languages_count']
    );
  }
}

class ESRAddProduction {
  Map<String, String> name = <String, String>{};
  Map<String, String> description = <String, String>{};
  String? imageBanner;
  String? videoBanner;
  String? spot;
  int schoolYearID;
  int userSchoolID;
  int productionTypeID;
  int languageID;
  int? zoneID;
  bool disabled = false;

  ESRAddProduction({
    required this.name,
    required this.description,
    this.imageBanner,
    this.videoBanner,
    this.spot,
    required this.schoolYearID,
    required this.userSchoolID,
    required this.productionTypeID,
    required this.languageID,
    this.zoneID,
    required this.disabled
  });
}