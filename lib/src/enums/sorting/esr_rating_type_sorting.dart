enum ESRRatingTypeSorting {
  id,
  name,
  disabled,
  inAverage,
  created
}

extension ESRRatingTypeSortingExtension on ESRRatingTypeSorting {
  String? get value {
    switch (this) {
      case ESRRatingTypeSorting.id:
        return 'id';
      case ESRRatingTypeSorting.name:
        return 'translations__name';
      case ESRRatingTypeSorting.disabled:
        return 'disabled';
      case ESRRatingTypeSorting.inAverage:
        return "in_average";
      case ESRRatingTypeSorting.created:
        return 'created';
    }
  }
}
