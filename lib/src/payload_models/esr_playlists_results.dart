import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRPlaylistsByUserResults {
  int count = 0;
  List<ESRPlaylist> results = [];

  ESRPlaylistsByUserResults({
    required this.count,
    required this.results
  });

  factory ESRPlaylistsByUserResults.fromJson(Map<String, dynamic> json){
    List<ESRPlaylist> serializedPlaylists = [];

    if ((!json.containsKey("data") || json['data'] == null) && json.containsKey("count")){
      return ESRPlaylistsByUserResults(
          count: json['count'] ?? 0,
          results: []
      );
    }

    List<dynamic> playlistsList = json['data'] as List<dynamic>;

    serializedPlaylists = playlistsList
        .map((singlePlaylist) => ESRPlaylist.fromJson(singlePlaylist as Map<String, dynamic>))
        .toList();

    return ESRPlaylistsByUserResults(
      count: json['count'] ?? 0,
      results: serializedPlaylists
    );
  }
}