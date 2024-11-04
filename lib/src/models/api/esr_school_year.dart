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
    return ESRSchoolYear(
        id: json['id'],
        name: json['name'],
        schedulableStartDate: DateTime.parse(json['schedulable_start_date']),
        schedulableEndDate: DateTime.parse(json['schedulable_end_date']),
        podcastsStartDate: DateTime.parse(json['podcasts_start_date']),
        podcastsEndDate: DateTime.parse(json['podcasts_end_date']),
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated']),
    );
  }
}