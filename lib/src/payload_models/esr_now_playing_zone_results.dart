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
    ESRZone? zoneDetailsTemp = null;
    DateTime? activeSince = null;
    DateTime? activeUntil = null;

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