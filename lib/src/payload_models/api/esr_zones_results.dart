import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRNowPlayingZoneResults {
  bool zoneFound = false;
  ESRZone? zoneDetails;
  DateTime? activeSince;
  DateTime? activeUntil;

  ESRNowPlayingZoneResults({
    required this.zoneFound,
    required this.zoneDetails,
    required this.activeSince,
    required this.activeUntil
  });

  factory ESRNowPlayingZoneResults.fromJson(Map<String, dynamic> json){
    ESRZone? zoneDetailsTemp;
    DateTime? activeSince;
    DateTime? activeUntil;

    if (json["zone_details"] != null){
      zoneDetailsTemp = ESRZone.fromJson(json["zone_details"]);

      DateTime now = DateTime.now();
      int dayOfWeek = 0;
      if (now.weekday == DateTime.sunday){
        dayOfWeek = 1;
      } else {
        dayOfWeek = now.weekday + 1;
      }

      for (ESRZoneSchedules zoneSchedules in zoneDetailsTemp.zoneSchedules){
        if (zoneSchedules.weekday.id == dayOfWeek){
          activeSince = zoneSchedules.timeFrom;
          activeUntil = zoneSchedules.timeTo;
          break;
        }
      }
    }

    return ESRNowPlayingZoneResults(
        zoneFound: json["zone_found"],
        zoneDetails: zoneDetailsTemp,
        activeSince: activeSince,
        activeUntil: activeUntil
    );
  }
}

class ESRZonesPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRZone> results = [];

  ESRZonesPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRZonesPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRZone> serializedZones = [];

    List<dynamic> zonesList = (json['zones'] ?? json['results']) as List<dynamic>;

    serializedZones = zonesList
        .map((singleZone) => ESRZone.fromJson(singleZone as Map<String, dynamic>))
        .where((item) => !item.disabled)
        .toList();

    return ESRZonesPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedZones.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedZones
    );
  }
}