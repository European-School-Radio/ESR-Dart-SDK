import 'package:intl/intl.dart';

class ESRSchoolYear {
  int id = 0;
  String name = "";
  DateTime schedulableStartDate = DateTime.now();
  DateTime schedulableEndDate = DateTime.now();
  DateTime podcastsStartDate = DateTime.now();
  DateTime podcastsEndDate = DateTime.now();
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRSchoolYear({
    required this.id,
    required this.name,
    required this.schedulableStartDate,
    required this.schedulableEndDate,
    required this.podcastsStartDate,
    required this.podcastsEndDate,
    required this.created,
    required this.updated
  });

  factory ESRSchoolYear.fromJson(Map<String, dynamic> json){
    DateFormat dateFormat = DateFormat("YYYY-mm-dd");
    DateTime utcSchedulableStart = dateFormat.parse(json['schedulable_start_date']);
    DateTime localSchedulableStart = DateTime.utc(
      utcSchedulableStart.year,
      utcSchedulableStart.month,
      utcSchedulableStart.day,
      utcSchedulableStart.hour,
      utcSchedulableStart.minute,
      utcSchedulableStart.second,
    ).toLocal();

    DateTime utcSchedulableEnd = dateFormat.parse(json['schedulable_end_date']);
    DateTime localSchedulableEnd = DateTime.utc(
      utcSchedulableEnd.year,
      utcSchedulableEnd.month,
      utcSchedulableEnd.day,
      utcSchedulableEnd.hour,
      utcSchedulableEnd.minute,
      utcSchedulableEnd.second,
    ).toLocal();

    DateTime utcPodcastStart = dateFormat.parse(json['podcasts_start_date']);
    DateTime localPodcastStart = DateTime.utc(
      utcPodcastStart.year,
      utcPodcastStart.month,
      utcPodcastStart.day,
      utcPodcastStart.hour,
      utcPodcastStart.minute,
      utcPodcastStart.second,
    ).toLocal();

    DateTime utcPodcastEnd = dateFormat.parse(json['podcasts_end_date']);
    DateTime localPodcastEnd = DateTime.utc(
      utcPodcastEnd.year,
      utcPodcastEnd.month,
      utcPodcastEnd.day,
      utcPodcastEnd.hour,
      utcPodcastEnd.minute,
      utcPodcastEnd.second,
    ).toLocal();

    return ESRSchoolYear(
        id: json['id'],
        name: json['name'],
        schedulableStartDate: localSchedulableStart,
        schedulableEndDate: localSchedulableEnd,
        podcastsStartDate: localPodcastStart,
        podcastsEndDate: localPodcastEnd,
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated'])
    );
  }
}