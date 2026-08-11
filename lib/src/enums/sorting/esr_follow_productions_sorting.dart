enum ESRFollowProductionsSorting {
  id,
  userID,
  userFirstName,
  userLastName,
  userNativeFirstName,
  userNativeLastName,
  userUsername,
  userFollowers,
  userCreated,
  productionID,
  productionName,
  productionDescription,
  productionSchoolYear,
  productionUserSchool,
  productionProductionType,
  productionLang,
  productionZone,
  productionFollowCount,
  productionLikesCount,
  productionSharesCount,
  productionDisabled,
  productionCreated,
  created
}

extension ESRFollowProductionsSortingExtension on ESRFollowProductionsSorting {
  String? get value {
    switch (this) {
      case ESRFollowProductionsSorting.id:
        return 'id';
      case ESRFollowProductionsSorting.userID:
        return "user__id";
      case ESRFollowProductionsSorting.userFirstName:
        return "user__first_name";
      case ESRFollowProductionsSorting.userLastName:
        return "user__last_name";
      case ESRFollowProductionsSorting.userNativeFirstName:
        return "user__native_first_name";
      case ESRFollowProductionsSorting.userNativeLastName:
        return "user__native_last_name";
      case ESRFollowProductionsSorting.userUsername:
        return "user__username";
      case ESRFollowProductionsSorting.userFollowers:
        return "user__follow_count";
      case ESRFollowProductionsSorting.userCreated:
        return "user__created";
      case ESRFollowProductionsSorting.productionID:
        return "production__id";
      case ESRFollowProductionsSorting.productionName:
        return "production__translations__name";
      case ESRFollowProductionsSorting.productionDescription:
        return "production__translations__description";
      case ESRFollowProductionsSorting.productionSchoolYear:
        return "production__school_year__id";
      case ESRFollowProductionsSorting.productionUserSchool:
        return "production__user_school__id";
      case ESRFollowProductionsSorting.productionProductionType:
        return "production__production_type__id";
      case ESRFollowProductionsSorting.productionLang:
        return "production__lang__id";
      case ESRFollowProductionsSorting.productionZone:
        return "production__zone__id";
      case ESRFollowProductionsSorting.productionFollowCount:
        return "production__follow_count";
      case ESRFollowProductionsSorting.productionLikesCount:
        return "production__likes_count";
      case ESRFollowProductionsSorting.productionSharesCount:
        return "production__shares_count";
      case ESRFollowProductionsSorting.productionDisabled:
        return "production__disabled";
      case ESRFollowProductionsSorting.productionCreated:
        return "production__created";
      case ESRFollowProductionsSorting.created:
        return "created";
    }
  }
}