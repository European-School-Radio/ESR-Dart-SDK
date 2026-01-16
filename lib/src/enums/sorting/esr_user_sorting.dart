enum ESRUserSorting {
  id,
  firstName,
  lastName,
  nativeFirstName,
  nativeLastName,
  username,
  followers,
  created
}

extension ESRUserSortingExtension on ESRUserSorting {
  String? get value {
    switch (this) {
      case ESRUserSorting.id:
        return 'id';
      case ESRUserSorting.firstName:
        return 'first_name';
      case ESRUserSorting.lastName:
        return 'last_name';
      case ESRUserSorting.nativeFirstName:
        return 'native_first_name';
      case ESRUserSorting.nativeLastName:
        return 'native_last_name';
      case ESRUserSorting.username:
        return 'username';
      case ESRUserSorting.followers:
        return "follow_count";
      case ESRUserSorting.created:
        return "created";
    }
  }
}
