import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRUsersLoginResults {
  bool success;
  String status;
  String message;
  ESRUserJwtData? jwtData;

  ESRUsersLoginResults(
      {required this.success,
      required this.status,
      required this.message,
      this.jwtData});

  factory ESRUsersLoginResults.fromJson(Map<String, dynamic> json) {
    return ESRUsersLoginResults(
        success: (json["status"] == "success"),
        status: json["status"],
        message: json["message"],
        jwtData: (json.containsKey("jwt_data") && json["jwt_data"] != null)
            ? ESRUserJwtData.fromJson(json["jwt_data"])
            : null);
  }
}

class ESRUsersRequestResetPasswordResults {
  String status = "";
  String message = "";

  ESRUsersRequestResetPasswordResults({
    required this.status,
    required this.message
  });

  factory ESRUsersRequestResetPasswordResults.fromJson(Map<String, dynamic> json){
    return ESRUsersRequestResetPasswordResults(
      status: json['status'],
      message: json['message']
    );
  }
}

class ESRUsersCheckResetTokenValidityResults {
  String status = "";

  ESRUsersCheckResetTokenValidityResults({
    required this.status
  });

  factory ESRUsersCheckResetTokenValidityResults.fromJson(Map<String, dynamic> json){
    return ESRUsersCheckResetTokenValidityResults(
      status: json['status']
    );
  }
}

class ESRUsersCancelResetTokenResults {
  String status = "";
  String message = "";

  ESRUsersCancelResetTokenResults({
    required this.status,
    required this.message
  });

  factory ESRUsersCancelResetTokenResults.fromJson(Map<String, dynamic> json){
    return ESRUsersCancelResetTokenResults(
      status: json['status'],
      message: json['message']
    );
  }
}

class ESRUsersResetPasswordResults {
  String status = "";
  String message = "";

  ESRUsersResetPasswordResults({
    required this.status,
    required this.message
  });

  factory ESRUsersResetPasswordResults.fromJson(Map<String, dynamic> json){
    return ESRUsersResetPasswordResults(
        status: json['status'],
        message: json['message']
    );
  }
}

class ESRUsersVerifyTokenResults {
  String status = "";
  String message = "";

  ESRUsersVerifyTokenResults({
    required this.status,
    required this.message
  });

  factory ESRUsersVerifyTokenResults.fromJson(Map<String, dynamic> json){
    return ESRUsersVerifyTokenResults(
      status: json['status'],
      message: json['message']
    );
  }
}

class ESRUsersVerifyUserResults {
  String status = "";
  String message = "";

  ESRUsersVerifyUserResults({
    required this.status,
    required this.message
  });

  factory ESRUsersVerifyUserResults.fromJson(Map<String, dynamic> json){
    return ESRUsersVerifyUserResults(
        status: json['status'],
        message: json['message']
    );
  }
}

class ESRUsersEditResults {
  String status = "";
  String message = "";

  ESRUsersEditResults({
    required this.status,
    required this.message
  });

  factory ESRUsersEditResults.fromJson(Map<String, dynamic> json){
    return ESRUsersEditResults(
      status: json['status'],
      message: json['message']
    );
  }
}

class ESRUsersCommunityRegisterResults {
  String message = "";
  int userID = 0;

  ESRUsersCommunityRegisterResults({
    required this.message,
    required this.userID
  });

  factory ESRUsersCommunityRegisterResults.fromJson(Map<String, dynamic> json){
    return ESRUsersCommunityRegisterResults(
      message: json['message'],
      userID: (json.containsKey("user_id")) ? json['user_id'] : 0
    );
  }
}

class ESRUsersCheckUsernameResults {
  String status = "";
  String message = "";
  bool exists = false;

  ESRUsersCheckUsernameResults({
    required this.status,
    required this.message,
    required this.exists
  });

  factory ESRUsersCheckUsernameResults.fromJson(Map<String, dynamic> json){
    return ESRUsersCheckUsernameResults(
      status: json['status'],
      message: json['message'],
      exists: json['exists']
    );
  }
}

class ESRUsersCheckEmailResults {
  String status = "";
  String message = "";
  bool exists = false;

  ESRUsersCheckEmailResults({
    required this.status,
    required this.message,
    required this.exists
  });

  factory ESRUsersCheckEmailResults.fromJson(Map<String, dynamic> json){
    return ESRUsersCheckEmailResults(
        status: json['status'],
        message: json['message'],
        exists: json['exists']
    );
  }
}

class ESRUsersWebsocketListResults {
  int count = 0;
  List<ESRUser> results = [];

  ESRUsersWebsocketListResults({
    required this.count,
    required this.results
  });

  factory ESRUsersWebsocketListResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRUser> serializedUsers = [];

    if (!json.containsKey("data") || json['data'] == null){
      return ESRUsersWebsocketListResults(
          count: 0,
          results: []
      );
    }

    List<dynamic> schoolsList = json['data'] as List<dynamic>;

    serializedUsers = schoolsList
        .map((singleUser) => ESRUser.fromJson(singleUser as Map<String, dynamic>))
        .toList();

    return ESRUsersWebsocketListResults(
        count: json['count'] ?? 0,
        results: serializedUsers
    );
  }
}

class ESRUsersPublicProfile {
  String status = "";
  ESRUserPublicProfile? userDetails;

  ESRUsersPublicProfile({
    required this.status,
    required this.userDetails
  });
  
  factory ESRUsersPublicProfile.fromJson(Map<String, dynamic> json){
    return ESRUsersPublicProfile(
      status: json['status'],
      userDetails: ESRUserPublicProfile.fromJson(json['user_details'])
    );
  }
}

class ESRUserCoverDataResults {
  String? coverURL;

  ESRUserCoverDataResults({
    required this.coverURL
  });

  factory ESRUserCoverDataResults.fromJson(Map<String, dynamic> json){
    return ESRUserCoverDataResults(
      coverURL: (json['cover_url'] != false) ? json['cover_url'] : null
    );
  }
}

class ESRUsersSimilarUsersResults {
  String status = "";
  List<ESRUserPublicProfile> similarUsers = [];

  ESRUsersSimilarUsersResults({
    required this.status,
    required this.similarUsers
  });

  factory ESRUsersSimilarUsersResults.fromJson(Map<String, dynamic> json){
    List<dynamic> usersList = json['similar_users'] as List<dynamic>;

    List<ESRUserPublicProfile> serializedUsers = usersList
        .map((singleUser) => ESRUserPublicProfile.fromJson(singleUser as Map<String, dynamic>))
        .toList();

    return ESRUsersSimilarUsersResults(
      status: json['status'],
      similarUsers: serializedUsers
    );
  }
}

class ESRUsersArchiveSuggestionsResults {
  String status = "";
  bool resultsAreSuggestions = false;
  List<ESRArchive> suggestedArchives = [];

  ESRUsersArchiveSuggestionsResults({
    required this.status,
    required this.resultsAreSuggestions,
    required this.suggestedArchives
  });

  factory ESRUsersArchiveSuggestionsResults.fromJson(Map<String, dynamic> json){
    List<dynamic> archivesList = json['suggested_archives'] as List<dynamic>;

    List<ESRArchive> serializedArchives = archivesList
        .map((singleArchive) => ESRArchive.fromJson(singleArchive as Map<String, dynamic>))
        .toList();

    return ESRUsersArchiveSuggestionsResults(
      status: json['status'],
      resultsAreSuggestions: json['results_are_suggestions'],
      suggestedArchives: serializedArchives
    );
  }
}

class ESRUsersFollowingEntitiesPagination {
  int totalCount = 0;
  int page = 0;
  int limit = 0;
  int totalPages = 0;
  bool hasNext = false;
  bool hasPrevious = false;

  ESRUsersFollowingEntitiesPagination({
    required this.totalCount,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrevious
  });

  factory ESRUsersFollowingEntitiesPagination.fromJson(Map<String, dynamic> json){
    return ESRUsersFollowingEntitiesPagination(
      totalCount: json['total_count'],
      page: json['page'],
      limit: json['limit'],
      totalPages: json['total_pages'],
      hasNext: json['has_next'],
      hasPrevious: json['has_previous']
    );
  }
}

class ESRUsersFollowingEntitiesSingleResult {
  int entityID = 0;
  String entity = "";
  ESRArchive? archive;

  ESRUsersFollowingEntitiesSingleResult({
    required this.entityID,
    required this.entity,
    required this.archive
  });

  factory ESRUsersFollowingEntitiesSingleResult.fromJson(Map<String, dynamic> json){
    return ESRUsersFollowingEntitiesSingleResult(
      entityID: json['entity_id'],
      entity: json['entity'],
      archive: ESRArchive.fromJson(json['archive'])
    );
  }
}

class ESRUsersFollowingEntitiesResults {
  String status = "";
  ESRUsersFollowingEntitiesPagination? pagination;
  List<ESRUsersFollowingEntitiesSingleResult>? followEntities;

  ESRUsersFollowingEntitiesResults({
    required this.status,
    required this.pagination,
    required this.followEntities
  });

  factory ESRUsersFollowingEntitiesResults.fromJson(Map<String, dynamic> json){
    List<dynamic> followEntitiesList = json['follow_entities'] as List<dynamic>;

    List<ESRUsersFollowingEntitiesSingleResult> serializedFollowEntities = followEntitiesList
        .map((singleFollowEntity) => ESRUsersFollowingEntitiesSingleResult.fromJson(singleFollowEntity as Map<String, dynamic>))
        .toList();

    return ESRUsersFollowingEntitiesResults(
      status: json['status'],
      pagination: ESRUsersFollowingEntitiesPagination.fromJson(json['pagination']),
      followEntities: serializedFollowEntities
    );
  }
}