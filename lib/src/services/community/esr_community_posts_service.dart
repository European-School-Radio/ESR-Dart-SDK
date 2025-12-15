import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRCommunityPostsService {
  String _apiURL = "";
  String _baseURL = "";

  ESRCommunityPostsService(){
    _apiURL = ESRServerConfig.communityApiUrl;
    _baseURL = ESRServerConfig.communityBaseUrl;
  }

  Future<List<ESRCommunityPost>> getAllPosts({
    int? page,
    int? limit,
    ESRLang? language
  }) async {
    String lang = "en";
    if (language != null){
      lang = language.flag;
    }

    final urlBuilder = UrlBuilder('$_baseURL/$lang/wp-json/wp/v2/posts');
    urlBuilder.addQueryParam("status", "publish");

    if (page != null) {
      urlBuilder.addQueryParam("page", page.toString());
    }

    if (limit != null) {
      urlBuilder.addQueryParam("per_page", limit.toString());
    }

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);

      List<ESRCommunityPost> communityPosts = [];
      if (jsonData is List<dynamic>) {
        communityPosts = jsonData
            .map((singlePost) =>
            ESRCommunityPost.fromJson(singlePost as Map<String, dynamic>))
            .toList();
      }
      return communityPosts;
    } else if (response.statusCode == 400){
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      if (jsonData['code'] == "rest_post_invalid_page_number"){
        throw NoMorePagesException("No more pages available");
      }
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRCommunityPost> getPostById(int id) async {
    var request = http.Request('GET', Uri.parse('$_apiURL/posts/$id'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRCommunityPost.fromJson(jsonData);
    } else if (response.statusCode == 404){
      throw ObjectNotFoundException("Post with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRCommunityPostReactions> getPostReactionsByUserForPost(int id) async {
    var request = http.Request('GET', Uri.parse('$_baseURL/wp-json/post/reactions/check/all/$id'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRCommunityPostReactions.fromJson(jsonData);
    } else if (response.statusCode == 404){
      throw ObjectNotFoundException("Post with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<int?> addAmazedReactionToPost(int id) async {
    var request = http.Request('GET', Uri.parse('$_baseURL/wp-json/post/add/amazed-reaction-post/$id'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return jsonData["meta_id"];
    } else if (response.statusCode == 404){
      throw ObjectNotFoundException("Post with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<int?> addAngerReactionToPost(int id) async {
    var request = http.Request('GET', Uri.parse('$_baseURL/wp-json/post/add/anger-reaction-post/$id'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return jsonData["meta_id"];
    } else if (response.statusCode == 404){
      throw ObjectNotFoundException("Post with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<int?> addBadReactionToPost(int id) async {
    var request = http.Request('GET', Uri.parse('$_baseURL/wp-json/post/add/bad-reaction-post/$id'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return jsonData["meta_id"];
    } else if (response.statusCode == 404){
      throw ObjectNotFoundException("Post with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<int?> addCoolReactionToPost(int id) async {
    var request = http.Request('GET', Uri.parse('$_baseURL/wp-json/post/add/cool-reaction-post/$id'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return jsonData["meta_id"];
    } else if (response.statusCode == 404){
      throw ObjectNotFoundException("Post with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<int?> addJoyReactionToPost(int id) async {
    var request = http.Request('GET', Uri.parse('$_baseURL/wp-json/post/add/joy-reaction-post/$id'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return jsonData["meta_id"];
    } else if (response.statusCode == 404){
      throw ObjectNotFoundException("Post with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<int?> addLikeReactionToPost(int id) async {
    var request = http.Request('GET', Uri.parse('$_baseURL/wp-json/post/add/like-reaction-post/$id'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return jsonData["meta_id"];
    } else if (response.statusCode == 404){
      throw ObjectNotFoundException("Post with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<int?> addLolReactionToPost(int id) async {
    var request = http.Request('GET', Uri.parse('$_baseURL/wp-json/post/add/lol-reaction-post/$id'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return jsonData["meta_id"];
    } else if (response.statusCode == 404){
      throw ObjectNotFoundException("Post with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<void> removeAmazedReactionFromPost(int reactionID) async {
    var request = http.Request('GET', Uri.parse('$_baseURL/wp-json/post/remove/amazed-reaction-post/$reactionID'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      await response.stream.bytesToString();
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<void> removeAngerReactionFromPost(int reactionID) async {
    var request = http.Request('GET', Uri.parse('$_baseURL/wp-json/post/remove/anger-reaction-post/$reactionID'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      await response.stream.bytesToString();
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<void> removeBadReactionFromPost(int reactionID) async {
    var request = http.Request('GET', Uri.parse('$_baseURL/wp-json/post/remove/bad-reaction-post/$reactionID'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      await response.stream.bytesToString();
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<void> removeCoolReactionFromPost(int reactionID) async {
    var request = http.Request('GET', Uri.parse('$_baseURL/wp-json/post/remove/cool-reaction-post/$reactionID'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      await response.stream.bytesToString();
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<void> removeJoyReactionFromPost(int reactionID) async {
    var request = http.Request('GET', Uri.parse('$_baseURL/wp-json/post/remove/joy-reaction-post/$reactionID'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      await response.stream.bytesToString();
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<void> removeLikeReactionFromPost(int reactionID) async {
    var request = http.Request('GET', Uri.parse('$_baseURL/wp-json/post/remove/like-reaction-post/$reactionID'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      await response.stream.bytesToString();
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<void> removeLolReactionFromPost(int reactionID) async {
    var request = http.Request('GET', Uri.parse('$_baseURL/wp-json/post/remove/lol-reaction-post/$reactionID'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      await response.stream.bytesToString();
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}