import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';
import 'package:intl/intl.dart';

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

    DateFormat hourFormat = DateFormat("HH:mm:ss");
    DateTime utcStartTime = hourFormat.parse(json['start_time']);
    DateTime localStartTime = DateTime.utc(
      utcStartTime.year,
      utcStartTime.month,
      utcStartTime.day,
      utcStartTime.hour,
      utcStartTime.minute,
      utcStartTime.second,
    ).toLocal();

    DateTime utcEndTime = hourFormat.parse(json['end_time']);
    DateTime localEndTime = DateTime.utc(
      utcEndTime.year,
      utcEndTime.month,
      utcEndTime.day,
      utcEndTime.hour,
      utcEndTime.minute,
      utcEndTime.second,
    ).toLocal();

    DateFormat dateFormat = DateFormat("yyyy-mm-dd");
    DateTime utcBroadcastDay = dateFormat.parse(json['broadcast_day']);
    DateTime localBroadcastDay = DateTime.utc(
      utcBroadcastDay.year,
      utcBroadcastDay.month,
      utcBroadcastDay.day,
      utcBroadcastDay.hour,
      utcBroadcastDay.minute,
      utcBroadcastDay.second,
    ).toLocal();

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
        broadcastDay: localBroadcastDay,
        startTime: localStartTime,
        endTime: localEndTime,
        tags: json['tags'],
        disabled: json['disabled'],
        averageRating: json['average_rating'],
        ratingsCount: json['ratings_count'],
        likesCount: json['likes_count'],
        listensCount: json['listens_count'],
        sharesCount: json['shares_count'],
        commentsCount: json['comments_count'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated']),
        archiveSubjects: serializedArchiveSubjects
    );
  }
}

class ESRAddArchive {
  int productionID;
  Map<String, String> name = <String, String>{};
  Map<String, String> description = <String, String>{};
  Map<String, String>? transcript = <String, String>{};
  String? imageBanner;
  String audioFile;
  int audioFileDuration;
  DateTime broadcastDay;
  DateTime startTime;
  DateTime endTime;
  bool disabled = false;

  ESRAddArchive({
    required this.productionID,
    required this.name,
    required this.description,
    this.transcript,
    this.imageBanner,
    required this.audioFile,
    required this.audioFileDuration,
    required this.broadcastDay,
    required this.startTime,
    required this.endTime,
    required this.disabled
  });
}