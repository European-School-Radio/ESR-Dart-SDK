import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRCommunityPostsService {
  String _apiURL = "";

  ESRCommunityPostsService(){
    _apiURL = ESRServerConfig.communityApiUrl;
  }

  Future<List<ESRCommunityPost>> getAllPosts({
    int? page,
    int? limit,
  }) async {
    final urlBuilder = UrlBuilder('$_apiURL/posts');
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
}