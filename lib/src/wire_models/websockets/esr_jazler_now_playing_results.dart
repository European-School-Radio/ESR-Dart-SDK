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

    DateTime now = DateTime.now();
    DateFormat format = DateFormat("HH:mm");

    DateTime parsedStartTime = format.parse(nowPlayingSongParsed["start_time"]);
    DateTime parsedExpireTime = format.parse(nowPlayingSongParsed["expire_time"]);
    Duration greeceOffset = Duration(
        hours: IsDaylightSaving.isDaylightSaving(parsedStartTime) ? 3 : 2);


    List<String> splitMediaRunTime = nowPlayingSongParsed["media_runtime"].toString().split(":");

    return ESRJazlerNowPlayingResults(
      message: (response["message"]) ?? "",
      startTime: parsedStartTime.subtract(greeceOffset).toLocal(),
      eventType: nowPlayingSongParsed["event_type"],
      songTitle: nowPlayingSongParsed["song_title"],
      artistName: nowPlayingSongParsed["artist_name"],
      jazlerID: nowPlayingSongParsed["jazler_id"],
      mediaRuntime: Duration(minutes: int.parse(splitMediaRunTime[0]), seconds: int.parse(splitMediaRunTime[1])),
      expireTime: parsedExpireTime.subtract(greeceOffset).toLocal()
    );
  }
}
