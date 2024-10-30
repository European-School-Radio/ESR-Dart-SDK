enum ESRProductionTypeSorting {
  id,
  name,
  description,
  maxSlots,
  isSpot,
  isRegular,
  isSchedulable,
  isSubjectBased,
  isSpecial,
  isLive,
  isPodcast,
  activeSince,
  activeUntil,
  maxAudioDuration,
  disabled,
  created
}

extension ESRProductionTypeSortingExtension on ESRProductionTypeSorting {
  String? get value {
    switch (this) {
      case ESRProductionTypeSorting.id:
        return 'id';
      case ESRProductionTypeSorting.name:
        return 'translations__name';
      case ESRProductionTypeSorting.description:
        return 'translations__description';
      case ESRProductionTypeSorting.maxSlots:
        return 'max_slots';
      case ESRProductionTypeSorting.isSpot:
        return "is_spot";
      case ESRProductionTypeSorting.isRegular:
        return "is_regular";
      case ESRProductionTypeSorting.isSchedulable:
        return "is_schedulable";
      case ESRProductionTypeSorting.isSubjectBased:
        return "is_subject_based";
      case ESRProductionTypeSorting.isSpecial:
        return "is_special";
      case ESRProductionTypeSorting.isLive:
        return "is_live";
      case ESRProductionTypeSorting.isPodcast:
        return "is_podcast";
      case ESRProductionTypeSorting.activeSince:
        return "active_since";
      case ESRProductionTypeSorting.activeUntil:
        return "active_until";
      case ESRProductionTypeSorting.maxAudioDuration:
        return "max_audio_duration";
      case ESRProductionTypeSorting.disabled:
        return "disabled";
      case ESRProductionTypeSorting.created:
        return 'created';
      default:
        return null;
    }
  }
}
