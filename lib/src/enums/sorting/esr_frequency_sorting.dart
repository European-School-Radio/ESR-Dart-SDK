enum ESRFrequencySorting {
  id,
  name,
  description,
  created
}

extension ESRFrequencySortingExtension on ESRFrequencySorting {
  String? get value {
    switch (this) {
      case ESRFrequencySorting.id:
        return 'id';
      case ESRFrequencySorting.name:
        return 'translations__name';
      case ESRFrequencySorting.description:
        return 'translations__description';
      case ESRFrequencySorting.created:
        return 'created';
      default:
        return null;
    }
  }
}
