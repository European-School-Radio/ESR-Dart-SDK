enum ESRAudioClassSorting {
  id,
  name,
  description,
  disabled,
  created
}

extension ESRAudioClassSortingExtension on ESRAudioClassSorting {
  String? get value {
    switch (this) {
      case ESRAudioClassSorting.id:
        return 'id';
      case ESRAudioClassSorting.name:
        return 'translations__name';
      case ESRAudioClassSorting.description:
        return 'translations__description';
      case ESRAudioClassSorting.disabled:
        return 'disabled';
      case ESRAudioClassSorting.created:
        return 'created';
    }
  }
}
