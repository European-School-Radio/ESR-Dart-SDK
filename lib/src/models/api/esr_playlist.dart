import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRPlaylist {
  int id = 0;
  String name = "";
  String description = "";
  bool isPublic = true;
  ESRUser? user;
  int followCount = 0;
  int likesCount = 0;
  int sharesCount = 0;
  int? playlistArchiveCount = 0;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRPlaylist({
    required this.id,
    required this.name,
    required this.description,
    required this.isPublic,
    required this.user,
    required this.followCount,
    required this.likesCount,
    required this.sharesCount,
    required this.playlistArchiveCount,
    required this.created,
    required this.updated
  });

  factory ESRPlaylist.fromJson(Map<String, dynamic> json){
    return ESRPlaylist(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isPublic: json['is_public'],
      user: ESRUser.fromJson(json['user']),
      followCount: json['follow_count'],
      likesCount: json['likes_count'],
      sharesCount: json['shares_count'],
      playlistArchiveCount: json['playlist_archive_count'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated'])
    );
  }
}