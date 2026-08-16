class ESRCommunityCommentsAddResults {
  String status = "";
  int commentID = 0;
  int postID = 0;
  String message = "";

  ESRCommunityCommentsAddResults({
    required this.status,
    required this.commentID,
    required this.postID,
    required this.message
  });

  factory ESRCommunityCommentsAddResults.fromJson(Map<String, dynamic> json){
    return ESRCommunityCommentsAddResults(
      status: json['status'],
      commentID: json['comment_id'],
      postID: json['post_id'],
      message: json['message']
    );
  }
}

class ESRCommunityCommentEditResults {
  String status = "";
  int commentID = 0;
  String message = "";

  ESRCommunityCommentEditResults({
    required this.status,
    required this.commentID,
    required this.message
  });

  factory ESRCommunityCommentEditResults.fromJson(Map<String, dynamic> json){
    return ESRCommunityCommentEditResults(
      status: json['status'],
      commentID: json['comment_id'],
      message: json['message']
    );
  }
}

class ESRCommunityCommentDeleteResults {
  String status = "";
  int commentID = 0;
  String message = "";

  ESRCommunityCommentDeleteResults({
    required this.status,
    required this.commentID,
    required this.message
  });

  factory ESRCommunityCommentDeleteResults.fromJson(Map<String, dynamic> json){
    return ESRCommunityCommentDeleteResults(
      status: json['status'],
      commentID: json['comment_id'],
      message: json['message']
    );
  }
}