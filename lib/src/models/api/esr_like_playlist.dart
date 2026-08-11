import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';

class ESRLikePlaylist {
  int id = 0;
  ESRPlaylist? playlist;
  ESRUser? user;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRLikePlaylist({
    required this.id,
    required this.playlist,
    required this.user,
    required this.created,
    required this.updated
  });

  factory ESRLikePlaylist.fromJson(Map<String, dynamic> json){
    return ESRLikePlaylist(
      id: json['id'],
      playlist: IsNumericUtils.isNumeric(json['playlist'].toString()) ? null : ESRPlaylist.fromJson(json['playlist']),
      user: IsNumericUtils.isNumeric(json['user'].toString()) ? null : ESRUser.fromJson(json['user']),
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated'])
    );
  }
}