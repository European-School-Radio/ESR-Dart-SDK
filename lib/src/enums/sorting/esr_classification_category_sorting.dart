enum ESRClassificationCategorySorting {
  id,
  uniqueName,
  name,
  description,
  disabled,
  created
}

extension ESRClassificationCategorySortingExtension on ESRClassificationCategorySorting {
  String? get value {
    switch (this) {
      case ESRClassificationCategorySorting.id:
        return 'id';
      case ESRClassificationCategorySorting.uniqueName:
        return "unique_name";
      case ESRClassificationCategorySorting.name:
        return 'translations__name';
      case ESRClassificationCategorySorting.description:
        return 'translations__description';
      case ESRClassificationCategorySorting.disabled:
        return 'disabled';
      case ESRClassificationCategorySorting.created:
        return 'created';
    }
  }
}
