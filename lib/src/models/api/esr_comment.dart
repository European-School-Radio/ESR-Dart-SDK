import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';

class ESRComment {
  int id = 0;
  ESRUser? user;
  ESRArchive? archive;
  String comment = "";
  ESRComment? reply;
  int audioTimestampDuration = 0;
  bool isDeleted = false;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();
  List<ESRComment> replies = [];

  ESRComment({
    required this.id,
    required this.user,
    required this.archive,
    required this.comment,
    required this.reply,
    required this.audioTimestampDuration,
    required this.isDeleted,
    required this.created,
    required this.updated,
    required this.replies
  });

  factory ESRComment.fromJson(Map<String, dynamic> json){
    List<ESRComment> serializedReplies = (json['replies'] as List<dynamic>)
        .map((singleComment) => ESRComment.fromJson(singleComment as Map<String, dynamic>))
        .toList();

    return ESRComment(
      id: json['id'],
      user: IsNumericUtils.isNumeric(json['user']) ? null : ESRUser.fromJson(json['user']),
      archive: IsNumericUtils.isNumeric(json['archive']) ? null : ESRArchive.fromJson(json['archive']),
      comment: json['comment'],
      reply: (json['reply'] == null) ? null : ESRComment.fromJson(json['reply']),
      audioTimestampDuration: json['audio_timestamp_duration'],
      isDeleted: json['is_deleted'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
      replies: serializedReplies
    );
  }
}