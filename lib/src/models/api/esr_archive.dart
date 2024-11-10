import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';

class ESRArchive {
  int id = 0;
  String name = "";
  String? description = "";
  String? banner = "";
  String? mp3File = "";
  int? duration = 0;
  String? transcript = "";
  String? sections = "";
  String? subtitles = "";
  ESRProduction? production;
  DateTime broadcastDay = DateTime.now();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  String? tags = "";
  bool disabled = false;
  double averageRating = 0.0;
  int ratingsCount = 0;
  int likesCount = 0;
  int listensCount = 0;
  int sharesCount = 0;
  int commentsCount = 0;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();
  List<ESRArchiveSubject> archiveSubjects = [];

  ESRArchive({
    required this.id,
    required this.name,
    required this.description,
    required this.banner,
    required this.mp3File,
    required this.duration,
    required this.transcript,
    required this.sections,
    required this.subtitles,
    required this.production,
    required this.broadcastDay,
    required this.startTime,
    required this.endTime,
    required this.tags,
    required this.disabled,
    required this.averageRating,
    required this.ratingsCount,
    required this.likesCount,
    required this.listensCount,
    required this.sharesCount,
    required this.commentsCount,
    required this.created,
    required this.updated,
    required this.archiveSubjects
  });

  factory ESRArchive.fromJson(Map<String, dynamic> json){
    List<ESRArchiveSubject> serializedArchiveSubjects = (json['archive_subjects'] as List<dynamic>)
        .map((singleArchiveSubject) => ESRArchiveSubject.fromJson(singleArchiveSubject as Map<String, dynamic>))
        .toList();

    return ESRArchive(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        banner: json['banner'],
        mp3File: json['mp3_file'],
        duration: json['duration'],
        transcript: json['transcript'],
        sections: json['sections'],
        subtitles: json['sections'],
        production: IsNumericUtils.isNumeric(json['production'].toString()) ? null : ESRProduction.fromJson(json['production']),
        broadcastDay: DateTime.parse(json['broadcast_day']).toLocal(),
        startTime: DateTime.parse('1970-01-01 ${json['start_time']}').toLocal(),
        endTime: DateTime.parse('1970-01-01 ${json['end_time']}').toLocal(),
        tags: json['tags'],
        disabled: json['disabled'],
        averageRating: json['average_rating'],
        ratingsCount: json['ratings_count'],
        likesCount: json['likes_count'],
        listensCount: json['listens_count'],
        sharesCount: json['shares_count'],
        commentsCount: json['comments_count'],
        created: DateTime.parse(json['created']).toLocal(),
        updated: DateTime.parse(json['updated']).toLocal(),
        archiveSubjects: serializedArchiveSubjects
    );
  }
}