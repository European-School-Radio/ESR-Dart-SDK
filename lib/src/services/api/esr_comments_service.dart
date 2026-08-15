import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/enums/directions/esr_sorting_directions.dart';
import 'package:esr_dart_sdk/src/enums/sorting/esr_comment_sorting.dart';
import 'package:esr_dart_sdk/src/global_parameters/server_config.dart';
import 'package:esr_dart_sdk/src/utils/url_builder.dart';
import 'package:http/http.dart' as http;

class ESRCommentsService {
  final sdk = ESRSDK();
  String _apiURL = "";

  ESRCommentsService(){
    if (sdk.env == ESREnvironments.test){
      _apiURL = ESRServerConfig.apiTestUrl;
    } else {
      _apiURL = ESRServerConfig.apiUrl;
    }
  }

  Future<ESRCommentsPaginatedResults> getAllComments({
    int? page,
    int? limit,
    ESRLang? language,
    ESRCommentSorting? sorting,
    ESRSortingDirections? direction
  }) async {
    final urlBuilder = UrlBuilder('$_apiURL/comments');

    if (page != null){
      urlBuilder.addQueryParam("page", page.toString());
    }

    if (limit != null){
      urlBuilder.addQueryParam("limit", limit.toString());
    }

    if (language != null){
      urlBuilder.addQueryParam("lang", language.flag.toString());
    } else {
      urlBuilder.addQueryParam("lang", "en");
    }

    if (sorting != null){
      urlBuilder.addQueryParam("sort", sorting.value.toString());
    }

    if (direction != null){
      urlBuilder.addQueryParam("direction", direction.value.toString());
    }

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRCommentsPaginatedResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRComment> getCommentById(int id, { ESRLang? language }) async {
    final urlBuilder = UrlBuilder('$_apiURL/comment/$id');

    if (language != null){
      urlBuilder.addQueryParam("lang", language.flag.toString());
    } else {
      urlBuilder.addQueryParam("lang", "en");
    }

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRComment.fromJson(jsonData['comment']);
    } else if (response.statusCode == 404){
      throw ObjectNotFoundException("Comment with id $id not found");
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRCommentsPaginatedResults> getCommentByArchiveId(int archiveID, {
    int? page,
    int? limit,
    ESRLang? language,
    ESRCommentSorting? sorting,
    ESRSortingDirections? direction
  }) async {
    final urlBuilder = UrlBuilder('$_apiURL/comment/byArchive/$archiveID');

    if (page != null){
      urlBuilder.addQueryParam("page", page.toString());
    }

    if (limit != null){
      urlBuilder.addQueryParam("limit", limit.toString());
    }

    if (language != null){
      urlBuilder.addQueryParam("lang", language.flag.toString());
    } else {
      urlBuilder.addQueryParam("lang", "en");
    }

    if (sorting != null){
      urlBuilder.addQueryParam("sort", sorting.value.toString());
    }

    if (direction != null){
      urlBuilder.addQueryParam("direction", direction.value.toString());
    }

    var request = http.Request('GET', Uri.parse(urlBuilder.build()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRCommentsPaginatedResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRCommentsAddResults> addComment(int archiveID, int userID, String comment, String jwt, {int? replyCommentID}) async {
    final urlBuilder = UrlBuilder('$_apiURL/comment/add');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $jwt'
    };
    var request = http.Request('POST', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      "user": userID.toString(),
      "archive": archiveID.toString(),
      "comment": comment
    };

    if (replyCommentID != null && replyCommentID != 0){
      request.bodyFields.addAll({
        'reply': replyCommentID.toString()
      });
    }

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201){
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRCommentsAddResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRCommentsEditResults> editComment(int commentID, String comment, String jwt) async {
    final urlBuilder = UrlBuilder('$_apiURL/comment/edit/$commentID');

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $jwt'
    };
    var request = http.Request('PUT', Uri.parse(urlBuilder.build()));
    request.bodyFields = {
      'comment': comment
    };
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200){
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRCommentsEditResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }

  Future<ESRCommentsDeleteResults> deleteComment(int commentID, String jwt) async {
    final urlBuilder = UrlBuilder('$_apiURL/comment/delete/$commentID');

    var headers = {
      'Authorization': 'Bearer $jwt'
    };
    var request = http.Request('DELETE', Uri.parse(urlBuilder.build()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200){
      var responsePlain = await response.stream.bytesToString();
      var jsonData = json.decode(responsePlain);
      return ESRCommentsDeleteResults.fromJson(jsonData);
    } else {
      throw HttpRequestNotSucceededException(response.reasonPhrase ?? "HTTP Request not Succeeded");
    }
  }
}