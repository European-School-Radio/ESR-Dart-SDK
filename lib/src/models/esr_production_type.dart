class ESRProductionType {
  int id = 0;
  String name = "";
  String? description;
  int maxSlots = 0;
  bool isSpot = false;
  bool isRegular = false;
  bool isSchedulable = false;
  bool isSubjectBased = false;
  bool isSpecial = false;
  bool isLive = false;
  bool isPodcast = false;
  DateTime? activeSince;
  DateTime? activeUntil;
  String maxAudioDuration = "";
  bool disabled = false;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRProductionType({
    required this.id,
    required this.name,
    this.description,
    required this.maxSlots,
    required this.isSpot,
    required this.isRegular,
    required this.isSchedulable,
    required this.isSubjectBased,
    required this.isSpecial,
    required this.isLive,
    required this.isPodcast,
    this.activeSince,
    this.activeUntil,
    required this.maxAudioDuration,
    required this.disabled,
    required this.created,
    required this.updated
  });

  factory ESRProductionType.fromJson(Map<String, dynamic> json){
    return ESRProductionType(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        maxSlots: json['max_slots'],
        isSpot: json['is_spot'],
        isRegular: json['is_regular'],
        isSchedulable: json['is_schedulable'],
        isSubjectBased: json['is_subject_based'],
        isSpecial: json['is_special'],
        isLive: json['is_live'],
        isPodcast: json['is_podcast'],
        activeSince: (json['active_since'] != null) ? DateTime.parse(json['active_since']) : null,
        activeUntil: (json['active_until'] != null) ? DateTime.parse(json['active_until']) : null,
        maxAudioDuration: json['max_audio_duration'],
        disabled: json['disabled'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated'])
    );
  }
}