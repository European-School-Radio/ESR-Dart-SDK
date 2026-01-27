import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';

class ESRFollowProduction {
  int id = 0;
  ESRProduction? production;
  ESRUser? user;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRFollowProduction({
    required this.id,
    required this.production,
    required this.user,
    required this.created,
    required this.updated
  });

  factory ESRFollowProduction.fromJson(Map<String, dynamic> json){
    return ESRFollowProduction(
      id: json['id'],
      production: (IsNumericUtils.isNumeric(json['production'].toString())) ? null : ESRProduction.fromJson(json['production']),
      user: (IsNumericUtils.isNumeric(json['user'].toString())) ? null : ESRUser.fromJson(json['user']),
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated'])
    );
  }
}