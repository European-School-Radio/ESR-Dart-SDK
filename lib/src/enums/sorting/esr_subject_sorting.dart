enum ESRSubjectSorting {
  id,
  name,
  description,
  disabled,
  created
}

extension ESRSubjectSortingExtension on ESRSubjectSorting {
  String? get value {
    switch (this) {
      case ESRSubjectSorting.id:
        return 'id';
      case ESRSubjectSorting.name:
        return 'translations__name';
      case ESRSubjectSorting.description:
        return 'translations__description';
      case ESRSubjectSorting.disabled:
        return 'disabled';
      case ESRSubjectSorting.created:
        return 'created';
      default:
        return null;
    }
  }
}
