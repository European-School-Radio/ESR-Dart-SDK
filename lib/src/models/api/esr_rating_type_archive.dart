import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';

class ESRRatingTypeArchive {
  int id = 0;
  ESRRatingType? ratingType;
  ESRArchive? archive;
  ESRUser? user;
  double ratingValue = 0.0;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRRatingTypeArchive({
    required this.id,
    required this.ratingType,
    required this.archive,
    required this.user,
    required this.ratingValue,
    required this.created,
    required this.updated
  });

  factory ESRRatingTypeArchive.fromJson(Map<String, dynamic> json){
    return ESRRatingTypeArchive(
      id: json['id'],
      ratingType: IsNumericUtils.isNumeric(json['rating_value'].toString()) ? null : ESRRatingType.fromJson(json['rating_value']),
      archive: IsNumericUtils.isNumeric(json['archive'].toString()) ? null : ESRArchive.fromJson(json['archive']),
      user: IsNumericUtils.isNumeric(json['user'].toString()) ? null : ESRUser.fromJson(json['user']),
      ratingValue: json['rating_value'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated'])
    );
  }
}