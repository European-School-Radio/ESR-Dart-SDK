enum ESRSchoolTypeSorting {
  id,
  name,
  description,
  unitsGroupId,
  created
}

extension ESRSchoolTypeSortingExtension on ESRSchoolTypeSorting {
  String? get value {
    switch (this) {
      case ESRSchoolTypeSorting.id:
        return 'id';
      case ESRSchoolTypeSorting.name:
        return 'translations__name';
      case ESRSchoolTypeSorting.description:
        return 'translations__description';
      case ESRSchoolTypeSorting.unitsGroupId:
        return 'units_group_id';
      case ESRSchoolTypeSorting.created:
        return 'created';
    }
  }
}
