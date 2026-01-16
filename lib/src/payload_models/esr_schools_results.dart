import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRSchoolsPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRSchool> results = [];

  ESRSchoolsPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRSchoolsPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRSchool> serializedSchools = [];

    List<dynamic> schoolsList = (json['schools'] ?? json['results']) as List<dynamic>;

    serializedSchools = schoolsList
        .map((singleSchool) => ESRSchool.fromJson(singleSchool as Map<String, dynamic>))
        .where((item) => !item.disabled)
        .toList();

    return ESRSchoolsPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedSchools.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedSchools
    );
  }
}

class ESRSchoolsMinimalData {
  int id = 0;
  String name = "";
  String? nativeName;

  ESRSchoolsMinimalData({
    required this.id,
    required this.name,
    required this.nativeName
  });

  factory ESRSchoolsMinimalData.fromJson(Map<String, dynamic> json){
    return ESRSchoolsMinimalData(
      id: json['id'],
      name: json['name'],
      nativeName: json['native_name']
    );
  }
}

class ESRSchoolsMinimalDataResults {
  String status = "";
  List<ESRSchoolsMinimalData> schoolMinimalData = [];

  ESRSchoolsMinimalDataResults({
    required this.status,
    required this.schoolMinimalData
  });

  factory ESRSchoolsMinimalDataResults.fromJson(Map<String, dynamic> json){
    List<ESRSchoolsMinimalData> serializedSchools = [];

    List<dynamic> schoolsList = json['school_minimal_data'] as List<dynamic>;

    serializedSchools = schoolsList
        .map((singleSchool) => ESRSchoolsMinimalData.fromJson(singleSchool as Map<String, dynamic>))
        .toList();

    return ESRSchoolsMinimalDataResults(
      status: json['status'],
      schoolMinimalData: serializedSchools
    );
  }
}

class ESRSchoolsWebsocketListResults {
  int count = 0;
  List<ESRSchool> results = [];

  ESRSchoolsWebsocketListResults({
    required this.count,
    required this.results
  });

  factory ESRSchoolsWebsocketListResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRSchool> serializedSchools = [];

    if (!json.containsKey("data") || json['data'] == null){
      return ESRSchoolsWebsocketListResults(
          count: 0,
          results: []
      );
    }

    List<dynamic> schoolsList = json['data'] as List<dynamic>;

    serializedSchools = schoolsList
        .map((singleSchool) => ESRSchool.fromJson(singleSchool as Map<String, dynamic>))
        .where((item) => !item.disabled)
        .toList();

    return ESRSchoolsWebsocketListResults(
        count: json['count'] ?? 0,
        results: serializedSchools
    );
  }
}