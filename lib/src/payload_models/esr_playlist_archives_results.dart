import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRPlaylistArchivesCheckExistsInPlaylist {
  String status = "";
  bool archiveExistsInPlaylist = false;

  ESRPlaylistArchivesCheckExistsInPlaylist({
    required this.status,
    required this.archiveExistsInPlaylist
  });

  factory ESRPlaylistArchivesCheckExistsInPlaylist.fromJson(Map<String, dynamic> json){
    return ESRPlaylistArchivesCheckExistsInPlaylist(
        status: json['status'],
        archiveExistsInPlaylist: json['archive_exists_in_playlist']
    );
  }
}

class ESRPlaylistArchivesAddArchiveToPlaylistResult {
  String status = "";
  String message = "";
  ESRPlaylistArchive? playlistArchive;

  ESRPlaylistArchivesAddArchiveToPlaylistResult({
    required this.status,
    required this.message,
    required this.playlistArchive
  });

  factory ESRPlaylistArchivesAddArchiveToPlaylistResult.fromJson(Map<String, dynamic> json){
    return ESRPlaylistArchivesAddArchiveToPlaylistResult(
      status: json['status'],
      message: json['message'],
      playlistArchive: ESRPlaylistArchive.fromJson(json['playlist_archive'])
    );
  }
}