enum ESRFollowUsersSorting {
  id,
  userID,
  userFirstName,
  userLastName,
  userNativeFirstName,
  userNativeLastName,
  userUsername,
  userFollowers,
  userCreated,
  userToFirstName,
  userToLastName,
  userToNativeFirstName,
  userToNativeLastName,
  userToUsername,
  userToFollowers,
  userToCreated,
  created
}

extension ESRFollowUsersSortingExtension on ESRFollowUsersSorting {
  String? get value {
    switch (this) {
      case ESRFollowUsersSorting.id:
        return 'id';
      case ESRFollowUsersSorting.userID:
        return "user__id";
      case ESRFollowUsersSorting.userFirstName:
        return "user__first_name";
      case ESRFollowUsersSorting.userLastName:
        return "user__last_name";
      case ESRFollowUsersSorting.userNativeFirstName:
        return "user__native_first_name";
      case ESRFollowUsersSorting.userNativeLastName:
        return "user__native_last_name";
      case ESRFollowUsersSorting.userUsername:
        return "user__username";
      case ESRFollowUsersSorting.userFollowers:
        return "user__follow_count";
      case ESRFollowUsersSorting.userCreated:
        return "user__created";
      case ESRFollowUsersSorting.userToFirstName:
        return "user_to__first_name";
      case ESRFollowUsersSorting.userToLastName:
        return "user_to__last_name";
      case ESRFollowUsersSorting.userToNativeFirstName:
        return "user_to__native_first_name";
      case ESRFollowUsersSorting.userToNativeLastName:
        return "user_to__native_last_name";
      case ESRFollowUsersSorting.userToUsername:
        return "user_to__username";
      case ESRFollowUsersSorting.userToFollowers:
        return "user_to__follow_count";
      case ESRFollowUsersSorting.userToCreated:
        return "user_to__created";
      case ESRFollowUsersSorting.created:
        return "created";
    }
  }
}