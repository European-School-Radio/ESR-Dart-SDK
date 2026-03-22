import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';

class ESRPlaylistArchive {
  int id = 0;
  ESRPlaylist? playlist;
  ESRArchive? archive;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRPlaylistArchive({
    required this.id,
    required this.playlist,
    required this.archive,
    required this.created,
    required this.updated
  });

  factory ESRPlaylistArchive.fromJson(Map<String, dynamic> json){
    return ESRPlaylistArchive(
      id: json['id'],
      playlist: (IsNumericUtils.isNumeric(json['playlist'])) ? null : ESRPlaylist.fromJson(json['playlist']),
      archive: (IsNumericUtils.isNumeric(json['archive'])) ? null : ESRArchive.fromJson(json['archive']),
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated'])
    );
  }
}