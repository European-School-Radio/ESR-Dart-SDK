import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRAudioClassesPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRAudioClass> results = [];

  ESRAudioClassesPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRAudioClassesPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRAudioClass> serializedAudioClasses = [];

    List<dynamic> audioClassesList = (json['audio_classes'] ?? json['results']) as List<dynamic>;

    serializedAudioClasses = audioClassesList
        .map((singleAudioClass) => ESRAudioClass.fromJson(singleAudioClass as Map<String, dynamic>))
        .toList();

    return ESRAudioClassesPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedAudioClasses.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedAudioClasses
    );
  }
}