import 'package:esr_dart_sdk/src/utils/is_daylight_saving.dart';
import 'package:intl/intl.dart';

class ESRJazlerNowPlayingResults {
  String message = "";
  DateTime startTime = DateTime.now();
  String eventType = "";
  String songTitle = "";
  String artistName = "";
  String jazlerID = "";
  Duration mediaRuntime = Duration.zero;
  DateTime expireTime = DateTime.now();

  ESRJazlerNowPlayingResults(
      {required this.message,
      required this.startTime,
      required this.eventType,
      required this.songTitle,
      required this.artistName,
      required this.jazlerID,
      required this.mediaRuntime,
      required this.expireTime});

  factory ESRJazlerNowPlayingResults.fromJson(Map<String, dynamic> response) {
    final Map<String, dynamic> nowPlayingSongParsed = response["data"];

    DateFormat format = DateFormat("HH:mm");

    DateTime parsedStartTime = format.parse(nowPlayingSongParsed["start_time"]);
    DateTime parsedExpireTime = format.parse(nowPlayingSongParsed["expire_time"]);
    Duration greeceOffset = Duration(
        hours: IsDaylightSaving.isDaylightSaving(parsedStartTime) ? 3 : 2);


    List<String> splitMediaRunTime = nowPlayingSongParsed["media_runtime"].toString().split(":");
    int mediaRunTimeMinutes = 0;
    int mediaRunTimeSeconds = 0;

    if (splitMediaRunTime.length == 2){
      mediaRunTimeMinutes = int.tryParse(splitMediaRunTime[0]) ?? 0;
      mediaRunTimeSeconds = int.tryParse(splitMediaRunTime[1]) ?? 0;
    }

    String eventType = "";
    try {
      eventType = nowPlayingSongParsed["event_type"];
    } on Exception {}

    String songTitle = "";
    try {
      songTitle = nowPlayingSongParsed["song_title"];
    } on Exception {}

    String artistName = "";
    try {
      artistName = nowPlayingSongParsed["artist_name"];
    } on Exception {}

    String jazlerID = "";
    try {
      jazlerID = nowPlayingSongParsed["jazler_id"];
    } on Exception {}


    return ESRJazlerNowPlayingResults(
      message: (response["message"]) ?? "",
      startTime: parsedStartTime.subtract(greeceOffset).toLocal(),
      eventType: eventType,
      songTitle: songTitle,
      artistName: artistName,
      jazlerID: jazlerID,
      mediaRuntime: Duration(minutes: mediaRunTimeMinutes, seconds: mediaRunTimeSeconds),
      expireTime: parsedExpireTime.subtract(greeceOffset).toLocal()
    );
  }
}
