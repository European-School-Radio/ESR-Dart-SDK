enum ESRGenderSorting {
  id,
  name,
  description,
  created
}

extension ESRGenderSortingExtension on ESRGenderSorting {
  String? get value {
    switch (this) {
      case ESRGenderSorting.id:
        return 'id';
      case ESRGenderSorting.name:
        return 'translations__name';
      case ESRGenderSorting.description:
        return 'translations__description';
      case ESRGenderSorting.created:
        return 'created';
    }
  }
}
