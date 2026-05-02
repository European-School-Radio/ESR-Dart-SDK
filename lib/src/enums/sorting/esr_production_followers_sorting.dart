enum ESRProductionFollowersSorting {
  id,
  userFirstName,
  userLastName,
  userNativeFirstName,
  userNativeLastName,
  userUsername,
  userFollowers,
  created
}

extension ESRProductionFollowersSortingExtension on ESRProductionFollowersSorting {
  String? get value {
    switch (this) {
      case ESRProductionFollowersSorting.id:
        return 'id';
      case ESRProductionFollowersSorting.userFirstName:
        return 'user__first_name';
      case ESRProductionFollowersSorting.userLastName:
        return 'user__last_name';
      case ESRProductionFollowersSorting.userNativeFirstName:
        return 'user__native_first_name';
      case ESRProductionFollowersSorting.userNativeLastName:
        return 'user__native_last_name';
      case ESRProductionFollowersSorting.userUsername:
        return 'user__username';
      case ESRProductionFollowersSorting.userFollowers:
        return 'user__follow_count';
      case ESRProductionFollowersSorting.created:
        return 'created';
    }
  }
}
