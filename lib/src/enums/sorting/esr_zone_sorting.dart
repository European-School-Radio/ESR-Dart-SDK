enum ESRZoneSorting {
  id,
  name,
  description,
  color,
  zoneType,
  disabled,
  created
}

extension ESRZoneSortingExtension on ESRZoneSorting {
  String? get value {
    switch (this) {
      case ESRZoneSorting.id:
        return 'id';
      case ESRZoneSorting.name:
        return 'translations__name';
      case ESRZoneSorting.description:
        return 'translations__description';
      case ESRZoneSorting.color:
        return 'color';
      case ESRZoneSorting.zoneType:
        return 'zone_type';
      case ESRZoneSorting.disabled:
        return 'disabled';
      case ESRZoneSorting.created:
        return 'created';
    }
  }
}
