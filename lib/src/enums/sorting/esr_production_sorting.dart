enum ESRProductionSorting {
  id,
  name,
  description,
  schoolYear,
  userSchool,
  productionType,
  lang,
  zone,
  followCount,
  likesCount,
  sharesCount,
  disabled,
  created
}

extension ESRProductionSortingExtension on ESRProductionSorting {
  String? get value {
    switch (this) {
      case ESRProductionSorting.id:
        return 'id';
      case ESRProductionSorting.name:
        return 'translations__name';
      case ESRProductionSorting.description:
        return 'translations__description';
      case ESRProductionSorting.schoolYear:
        return 'school_year__id';
      case ESRProductionSorting.userSchool:
        return 'user_school__id';
      case ESRProductionSorting.productionType:
        return 'production_type__id';
      case ESRProductionSorting.lang:
        return 'lang__id';
      case ESRProductionSorting.zone:
        return 'zone__id';
      case ESRProductionSorting.followCount:
        return 'follow_count';
      case ESRProductionSorting.likesCount:
        return 'likes_count';
      case ESRProductionSorting.sharesCount:
        return 'shares_count';
      case ESRProductionSorting.disabled:
        return 'disabled';
      case ESRProductionSorting.created:
        return 'created';
      default:
        return null;
    }
  }
}
