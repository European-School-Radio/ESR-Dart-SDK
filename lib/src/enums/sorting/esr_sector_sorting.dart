enum ESRSectorSorting {
  id,
  name,
  created
}

extension ESRSubjectSortingExtension on ESRSectorSorting {
  String? get value {
    switch (this) {
      case ESRSectorSorting.id:
        return 'id';
      case ESRSectorSorting.name:
        return 'translations__name';
      case ESRSectorSorting.created:
        return 'created';
    }
  }
}
