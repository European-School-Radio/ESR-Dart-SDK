enum ESRAgeCategorySorting {
  id,
  name,
  description,
  disabled,
  created
}

extension ESRAgeCategorySortingExtension on ESRAgeCategorySorting {
  String? get value {
    switch (this) {
      case ESRAgeCategorySorting.id:
        return 'id';
      case ESRAgeCategorySorting.name:
        return 'translations__name';
      case ESRAgeCategorySorting.description:
        return 'translations__description';
      case ESRAgeCategorySorting.disabled:
        return 'disabled';
      case ESRAgeCategorySorting.created:
        return 'created';
    }
  }
}
