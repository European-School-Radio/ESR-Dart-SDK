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