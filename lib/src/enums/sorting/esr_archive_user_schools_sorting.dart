enum ESRArchiveUserSchoolsSorting {
  id,
  userFirstName,
  userLastName,
  userNativeFirstName,
  userNativeLastName,
  archiveName
}

extension ESRArchiveUserSchoolsSortingExtension on ESRArchiveUserSchoolsSorting {
  String? get value {
    switch (this){
      case ESRArchiveUserSchoolsSorting.id:
        return 'id';
      case ESRArchiveUserSchoolsSorting.userFirstName:
        return 'user_school__user__first_name';
      case ESRArchiveUserSchoolsSorting.userLastName:
        return 'user_school__user__last_name';
      case ESRArchiveUserSchoolsSorting.userNativeFirstName:
        return 'user_school__user__native_first_name';
      case ESRArchiveUserSchoolsSorting.userNativeLastName:
        return 'user_school__user__native_last_name';
      case ESRArchiveUserSchoolsSorting.archiveName:
        return 'user_school__archive__translations__name';
    }
  }
}