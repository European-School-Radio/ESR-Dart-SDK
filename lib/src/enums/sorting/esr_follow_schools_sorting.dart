enum ESRFollowSchoolsSorting {
  id,
  schoolID,
  schoolName,
  schoolDescription,
  schoolNativeName,
  schoolNativeDescription,
  schoolSchoolType,
  schoolCountry,
  schoolCity,
  schoolAddress,
  schoolZipCode,
  schoolLatitude,
  schoolLongitude,
  schoolOfficialNumber,
  schoolEmail,
  schoolPhone,
  schoolFollowCount,
  schoolSharesCount,
  schoolDisabled,
  schoolCreated,
  userID,
  userFirstName,
  userLastName,
  userNativeFirstName,
  userNativeLastName,
  userUsername,
  userFollowers,
  userCreated,
  created
}

extension ESRFollowSchoolsSortingExtension on ESRFollowSchoolsSorting {
  String? get value {
    switch (this) {
      case ESRFollowSchoolsSorting.id:
        return "id";
      case ESRFollowSchoolsSorting.schoolID:
        return "school__id";
      case ESRFollowSchoolsSorting.schoolName:
        return "school__name";
      case ESRFollowSchoolsSorting.schoolDescription:
        return "school__description";
      case ESRFollowSchoolsSorting.schoolNativeName:
        return "school__native_name";
      case ESRFollowSchoolsSorting.schoolNativeDescription:
        return "school_native_description";
      case ESRFollowSchoolsSorting.schoolSchoolType:
        return "school__school_type__id";
      case ESRFollowSchoolsSorting.schoolCountry:
        return "school__country__id";
      case ESRFollowSchoolsSorting.schoolCity:
        return 'school__city';
      case ESRFollowSchoolsSorting.schoolAddress:
        return 'school__address';
      case ESRFollowSchoolsSorting.schoolZipCode:
        return 'school__zip_code';
      case ESRFollowSchoolsSorting.schoolLatitude:
        return 'school__latitude';
      case ESRFollowSchoolsSorting.schoolLongitude:
        return 'school__longitude';
      case ESRFollowSchoolsSorting.schoolOfficialNumber:
        return 'school__official_number';
      case ESRFollowSchoolsSorting.schoolEmail:
        return 'school__email';
      case ESRFollowSchoolsSorting.schoolPhone:
        return 'school__phone';
      case ESRFollowSchoolsSorting.schoolFollowCount:
        return 'school__follow_count';
      case ESRFollowSchoolsSorting.schoolSharesCount:
        return 'school__shares_count';
      case ESRFollowSchoolsSorting.schoolDisabled:
        return 'school__disabled';
      case ESRFollowSchoolsSorting.schoolCreated:
        return 'school__created';
      case ESRFollowSchoolsSorting.userID:
        return "user__id";
      case ESRFollowSchoolsSorting.userFirstName:
        return "user__first_name";
      case ESRFollowSchoolsSorting.userLastName:
        return "user__last_name";
      case ESRFollowSchoolsSorting.userNativeFirstName:
        return "user__native_first_name";
      case ESRFollowSchoolsSorting.userNativeLastName:
        return "user__native_last_name";
      case ESRFollowSchoolsSorting.userUsername:
        return "user__username";
      case ESRFollowSchoolsSorting.userFollowers:
        return "user__follow_count";
      case ESRFollowSchoolsSorting.userCreated:
        return "user__created";
      case ESRFollowSchoolsSorting.created:
        return "created";
    }
  }
}