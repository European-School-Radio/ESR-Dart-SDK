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
  String? email;
  String? phone;
  String? banner;
  String? spot;
  int followCount = 0;
  int sharesCount = 0;
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
    this.email,
    this.phone,
    this.banner,
    this.spot,
    required this.followCount,
    required this.sharesCount,
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
        email: json['email'],
        phone: json['phone'],
        followCount: json['follow_count'],
        sharesCount: json['shares_count'],
        disabled: json['disabled'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated'])
    );
  }
}