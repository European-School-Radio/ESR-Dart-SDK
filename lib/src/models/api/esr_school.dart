import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRSchool {
  int id = 0;
  String name = "";
  String description = "";
  String? nativeName;
  String? nativeDescription;
  ESRSchoolType schoolType;
  ESRCountry country;
  String city = "";
  String address = "";
  String zipCode = "";
  double? latitude;
  double? longitude;
  String? officialNumber;
  String? ssoModel;
  String? email;
  String? phone;
  String? banner;
  String? spot;
  int followCount = 0;
  int sharesCount = 0;
  int schoolUsersCount = 0;
  int schoolProductionsCount = 0;
  bool disabled = false;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRSchool({
    required this.id,
    required this.name,
    required this.description,
    this.nativeName,
    this.nativeDescription,
    required this.schoolType,
    required this.country,
    required this.city,
    required this.address,
    required this.zipCode,
    required this.latitude,
    required this.longitude,
    this.officialNumber,
    this.ssoModel,
    this.email,
    this.phone,
    this.banner,
    this.spot,
    required this.followCount,
    required this.sharesCount,
    required this.schoolUsersCount,
    required this.schoolProductionsCount,
    required this.disabled,
    required this.created,
    required this.updated
  });

  factory ESRSchool.fromJson(Map<String, dynamic> json){
    return ESRSchool(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        schoolType: ESRSchoolType.fromJson(json['school_type']),
        country: ESRCountry.fromJson(json['country']),
        city: json['city'],
        address: json['address'],
        zipCode: json['zip_code'],
        latitude: (json['latitude'] != null) ? double.tryParse(json['latitude']) : null,
        longitude: (json['longitude'] != null) ? double.tryParse(json['longitude']) : null,
        officialNumber: json['official_number'],
        ssoModel: json['sso_model'],
        email: json['email'],
        phone: json['phone'],
        followCount: json['follow_count'],
        sharesCount: json['shares_count'],
        schoolUsersCount: json['school_users_count'],
        schoolProductionsCount: json['school_productions_count'],
        disabled: json['disabled'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated'])
    );
  }
}

class ESRAddSchool {
  String name = "";
  String description = "";
  String nativeName = "";
  String nativeDescription = "";
  int schoolTypeID;
  int countryID;
  String city = "";
  String address = "";
  String zipCode = "";
  double latitude = 0.0;
  double longitude = 0.0;
  String officialNumber = "";
  String email = "";
  String phone = "";
  bool disabled = false;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRAddSchool({
    required this.name,
    required this.description,
    required this.nativeName,
    required this.nativeDescription,
    required this.schoolTypeID,
    required this.countryID,
    required this.city,
    required this.address,
    required this.zipCode,
    required this.latitude,
    required this.longitude,
    required this.officialNumber,
    required this.email,
    required this.phone,
    required this.disabled,
    required this.created,
    required this.updated
  });
}

class ESRSchoolMap {
  int id = 0;
  String name = "";
  String? nativeName;
  double latitude = 0.0;
  double longitude = 0.0;
  ESRSchoolType? schoolType;

  ESRSchoolMap({
    required this.id,
    required this.name,
    required this.nativeName,
    required this.latitude,
    required this.longitude,
    required this.schoolType
  });
  
  factory ESRSchoolMap.fromJson(Map<String, dynamic> json){
    return ESRSchoolMap(
      id: json['id'],
      name: json['name'],
      nativeName: json['native_name'],
      latitude: (json['latitude'] != null) ? (double.tryParse(json['latitude'].toString()) ?? 0.0) : 0.0,
      longitude: (json['longitude'] != null) ? (double.tryParse(json['longitude'].toString()) ?? 0.0) : 0.0,
      schoolType: ESRSchoolType.fromJson(json['school_type'])
    );
  }
}