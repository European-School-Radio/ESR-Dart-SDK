import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';

class ESRLikeArchive {
  int id = 0;
  ESRArchive? archive;
  ESRUser? user;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRLikeArchive({
    required this.id,
    required this.archive,
    required this.user,
    required this.created,
    required this.updated
  });

  factory ESRLikeArchive.fromJson(Map<String, dynamic> json){
    return ESRLikeArchive(
      id: json['id'],
      archive: IsNumericUtils.isNumeric(json['archive'].toString()) ? null : ESRArchive.fromJson(json['archive']),
      user: IsNumericUtils.isNumeric(json['user'].toString()) ? null : ESRUser.fromJson(json['user']),
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated'])
    );
  }
}