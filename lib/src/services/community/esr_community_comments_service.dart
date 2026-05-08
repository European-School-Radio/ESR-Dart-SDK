import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/directions/esr_sorting_directions.dart';
import 'package:esr_dart_sdk/src/enums/sorting/community/esr_community_comment_sorting.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRCommunityCommentsService {
  String _baseURL = "";

  ESRCommunityCommentsService(){
    _baseURL = ESRServerConfig.communityBaseUrl;
  }

  Future<List<ESRCommunityComment>> getCommentsByPost(int postID, {
    int? page,
    int? limit,
    ESRLang? language,
    ESRCommunityCommentSorting? commentSorting,
    ESRSortingDirections? commentSortDirection
  }) async {
    String lang = "en";
    if (language != null){
      lang = language.flag;
    }

    final urlBuilder = UrlBuilder('$_baseURL/$lang/wp-json/wp/v2/comments');

    urlBuilder.addQueryParam("post", postID.toString());
    urlBuilder.addQueryParam("status", "approve");

    if (page != null) {
      urlBuilder.addQueryParam("page", page.toString());
    }

    if (limit != null) {
      urlBuilder.addQueryParam("per_page", limit.toString());
    }

    if (commentSorting != null){
      urlBuilder.addQueryParam("orderby", commentSorting.value.toString());
    } else {
      urlBuilder.addQueryParam("orderby", ESRCommunityCommentSorting.date.value.toString());
    }

    if (commentSortDirection != null){
      urlBuilder.addQueryParam("order", commentSortDirection.value.toString());
    } else {
      urlBuilder.addQueryParam("order", ESRSortingDirections.desc.value.toString().toLowerCase());
    }

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);

      List<ESRCommunityComment> communityComments = [];
      if (jsonData is List<dynamic>) {
        communityComments = jsonData
            .map((singlePost) =>
            ESRCommunityComment.fromJson(singlePost as Map<String, dynamic>))
            .toList();
      }
      return communityComments;
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

  Future<ESRCommunityCountCommentsByPost> getCommentsCounterByPost(int postID, {ESRLang? language}) async {
    String lang = "en";
    if (language != null){
      lang = language.flag;
    }

    final urlBuilder = UrlBuilder('$_baseURL/$lang/wp-json/custom/post-comments/$postID');

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRCommunityCountCommentsByPost.fromJson(jsonData);
    } else if (response.statusCode == 400){
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    } else if (response.statusCode == 404){
      throw ObjectNotFoundException("Post with id $postID not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}