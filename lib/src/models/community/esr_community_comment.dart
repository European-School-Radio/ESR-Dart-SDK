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
  List<ESRCommunityCommentReply> replies = [];

  ESRCommunityComment({
    required this.id,
    required this.publishedDate,
    required this.commentUrl,
    required this.status,
    required this.type,
    required this.content,
    required this.authorName,
    required this.authorUsername,
    required this.authorUserID,
    required this.replies
  });

  factory ESRCommunityComment.fromJson(Map<String, dynamic> json){
    var unescape = HtmlUnescape();

    List<ESRCommunityCommentReply> serializedReplies = [];

    if (json.containsKey("replies") && json['replies'] != null && json['replies'].length != 0){
      serializedReplies = (json['replies'] as List<dynamic>)
          .map((singleComment) => ESRCommunityCommentReply.fromJson(singleComment as Map<String, dynamic>))
          .toList();
    }

    return ESRCommunityComment(
      id: json['id'],
      publishedDate: DateTime.parse(json['date_gmt'] + "Z").toLocal(),
      commentUrl: json['link'],
      status: json['status'],
      type: json['type'],
      content: unescape.convert(json['content']['rendered']),
      authorName: json['author_name'],
      authorUsername: json['author_username'],
      authorUserID: json['author_id'],
      replies: serializedReplies
    );
  }
}

class ESRCommunityCommentReply {
  int id = 0;
  int parent = 0;
  String content = "";
  String authorName = "";
  int authorID = 0;
  DateTime created = DateTime.now();

  ESRCommunityCommentReply({
    required this.id,
    required this.parent,
    required this.content,
    required this.authorName,
    required this.authorID,
    required this.created
  });

  factory ESRCommunityCommentReply.fromJson(Map<String, dynamic> json){
    var unescape = HtmlUnescape();

    return ESRCommunityCommentReply(
      id: json['id'],
      parent: json['parent'],
      content: unescape.convert(json['content']),
      authorName: json['author_name'],
      authorID: json['author_id'],
      created: DateTime.parse(json['date_gmt'])
    );
  }
}

class ESRCommunityCountCommentsByPost {
  String status = "";
  int postID = 0;
  int commentsCount = 0;

  ESRCommunityCountCommentsByPost({
    required this.status,
    required this.postID,
    required this.commentsCount
  });

  factory ESRCommunityCountCommentsByPost.fromJson(Map<String, dynamic> json){
    return ESRCommunityCountCommentsByPost(
      status: json['status'],
      postID: json['post_id'],
      commentsCount: json['total_comments']
    );
  }
}