enum ESRUsersSchoolsSorting {
  id,
  userID,
  userFirstName,
  userLastName,
  userNativeFirstName,
  userNativeLastName,
  userUsername,
  userRole,
  userFollowers,
  userCreated,
  schoolID,
  schoolName,
  schoolNativeName,
  schoolDescription,
  schoolNativeDescription,
  schoolType,
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
  role,
  disabled,
  created
}

extension ESRUsersSchoolsSortingExtension on ESRUsersSchoolsSorting {
  String? get value {
    switch (this) {
      case ESRUsersSchoolsSorting.id:
        return 'id';
      case ESRUsersSchoolsSorting.userID:
        return 'user__id';
      case ESRUsersSchoolsSorting.userFirstName:
        return 'user__first_name';
      case ESRUsersSchoolsSorting.userLastName:
        return 'user__last_name';
      case ESRUsersSchoolsSorting.userNativeFirstName:
        return 'user__native_first_name';
      case ESRUsersSchoolsSorting.userNativeLastName:
        return 'user__native_last_name';
      case ESRUsersSchoolsSorting.userUsername:
        return 'user__username';
      case ESRUsersSchoolsSorting.userRole:
        return 'user__role__id';
      case ESRUsersSchoolsSorting.userFollowers:
        return 'user__followers';
      case ESRUsersSchoolsSorting.userCreated:
        return 'user__created';
      case ESRUsersSchoolsSorting.schoolID:
        return 'school__id';
      case ESRUsersSchoolsSorting.schoolName:
        return 'school__name';
      case ESRUsersSchoolsSorting.schoolNativeName:
        return 'school__native_name';
      case ESRUsersSchoolsSorting.schoolDescription:
        return 'school__description';
      case ESRUsersSchoolsSorting.schoolNativeDescription:
        return 'school__native_description';
      case ESRUsersSchoolsSorting.schoolType:
        return 'school__school_type__id';
      case ESRUsersSchoolsSorting.schoolCountry:
        return 'school__country__id';
      case ESRUsersSchoolsSorting.schoolCity:
        return 'school__city';
      case ESRUsersSchoolsSorting.schoolAddress:
        return 'school__address';
      case ESRUsersSchoolsSorting.schoolZipCode:
        return 'school__zip_code';
      case ESRUsersSchoolsSorting.schoolLatitude:
        return 'school__latitude';
      case ESRUsersSchoolsSorting.schoolLongitude:
        return 'school__longitude';
      case ESRUsersSchoolsSorting.schoolOfficialNumber:
        return 'school__official_number';
      case ESRUsersSchoolsSorting.schoolEmail:
        return 'school__email';
      case ESRUsersSchoolsSorting.schoolPhone:
        return 'school__phone';
      case ESRUsersSchoolsSorting.schoolFollowCount:
        return 'school__follow_count';
      case ESRUsersSchoolsSorting.schoolSharesCount:
        return 'school__shares_count';
      case ESRUsersSchoolsSorting.schoolDisabled:
        return 'school__disabled';
      case ESRUsersSchoolsSorting.schoolCreated:
        return 'school__created';
      case ESRUsersSchoolsSorting.role:
        return 'role__id';
      case ESRUsersSchoolsSorting.disabled:
        return 'disabled';
      case ESRUsersSchoolsSorting.created:
        return 'created';
    }
  }
}