import 'package:html_unescape/html_unescape.dart';

class ESRCommunityPost {
  int id = 0;
  DateTime publishedDate = DateTime.now();
  String postUrl = "";
  String slug = "";
  String status = "";
  String type = "";
  String title = "";
  String content = "";
  String excerpt = "";
  String? featuredMediaUrl = "";
  String? featuredMediaAlternativeText = "";
  int commentCounter = 0;
  int likeCounter = 0;
  int lolReactionCounter = 0;
  int joyCounter = 0;
  int coolCounter = 0;
  int badCounter = 0;
  int angerCounter = 0;
  int amazedCounter = 0;

  ESRCommunityPost({
    required this.id,
    required this.publishedDate,
    required this.postUrl,
    required this.slug,
    required this.status,
    required this.type,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.featuredMediaUrl,
    required this.featuredMediaAlternativeText,
    required this.commentCounter,
    required this.likeCounter,
    required this.lolReactionCounter,
    required this.joyCounter,
    required this.coolCounter,
    required this.badCounter,
    required this.angerCounter,
    required this.amazedCounter
  });

  int getReactionsTotalCount(){
    return (likeCounter + lolReactionCounter + joyCounter + coolCounter + badCounter + angerCounter + amazedCounter);
  }

  factory ESRCommunityPost.fromJson(Map<String, dynamic> json){
    var unescape = HtmlUnescape();

    return ESRCommunityPost(
        id: json['id'],
        publishedDate: DateTime.parse(json['date_gmt'] + "Z").toLocal(),
        postUrl: json['link'],
        slug: json['slug'],
        status: json['status'],
        type: json['type'],
        title: unescape.convert(json['title']['rendered']),
        content: json['content']['rendered'],
        excerpt: json['excerpt']['rendered'],
        featuredMediaUrl: json['featured_image']['href'],
        featuredMediaAlternativeText: json['featured_image']['alternative_text'],
        commentCounter: json['comments_counter'],
        likeCounter: int.parse(json['reactions_counter']['reaction_like']),
        lolReactionCounter: int.parse(json['reactions_counter']['reaction_lol']),
        joyCounter: int.parse(json['reactions_counter']['reaction_joy']),
        coolCounter: int.parse(json['reactions_counter']['reaction_cool']),
        badCounter: int.parse(json['reactions_counter']['reaction_bad']),
        angerCounter: int.parse(json['reactions_counter']['reaction_anger']),
        amazedCounter: int.parse(json['reactions_counter']['reaction_amazed'])
    );
  }
}