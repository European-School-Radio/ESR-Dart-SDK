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
        schedulableStartDate: DateTime.parse(json['schedulable_start_date']).toLocal(),
        schedulableEndDate: DateTime.parse(json['schedulable_end_date']).toLocal(),
        podcastsStartDate: DateTime.parse(json['podcasts_start_date']).toLocal(),
        podcastsEndDate: DateTime.parse(json['podcasts_end_date']).toLocal(),
        created: DateTime.parse(json['created']).toLocal(),
        updated: DateTime.parse(json['updated']).toLocal()
    );
  }
}