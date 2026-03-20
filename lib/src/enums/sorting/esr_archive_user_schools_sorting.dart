enum ESRArchiveUserSchoolsSorting {
  id,
  userFirstName,
  userLastName,
  userNativeFirstName,
  userNativeLastName,
  archiveName,
  archiveLikesCount,
  archiveSharesCount,
  archiveCreated
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
        return 'archive__translations__name';
      case ESRArchiveUserSchoolsSorting.archiveLikesCount:
        return 'archive__likes_count';
      case ESRArchiveUserSchoolsSorting.archiveSharesCount:
        return 'archive__shares_count';
      case ESRArchiveUserSchoolsSorting.archiveCreated:
        return 'archive__created';
    }
  }
}