import 'package:html_unescape/html_unescape.dart';

class ESRCommunityComment {
  int id = 0;
  DateTime publishedDate = DateTime.now();
  String commentUrl = "";
  String status = "";
  String type = "";
  String content = "";
  String authorName = "";
  String? authorUsername = "";
  int? authorUserID = 0;

  ESRCommunityComment({
    required this.id,
    required this.publishedDate,
    required this.commentUrl,
    required this.status,
    required this.type,
    required this.content,
    required this.authorName,
    required this.authorUsername,
    required this.authorUserID
  });

  factory ESRCommunityComment.fromJson(Map<String, dynamic> json){
    var unescape = HtmlUnescape();

    return ESRCommunityComment(
      id: json['id'],
      publishedDate: DateTime.parse(json['date_gmt'] + "Z").toLocal(),
      commentUrl: json['link'],
      status: json['status'],
      type: json['type'],
      content: unescape.convert(json['content']['rendered']),
      authorName: json['author_name'],
      authorUsername: json['author_username'],
      authorUserID: json['author_id']
    );
  }
}