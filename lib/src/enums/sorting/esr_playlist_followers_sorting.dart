enum ESRPlaylistFollowersSorting {
  id,
  userFirstName,
  userLastName,
  userNativeFirstName,
  userNativeLastName,
  userUsername,
  userFollowers,
  created
}

extension ESRPlaylistFollowersSortingExtension on ESRPlaylistFollowersSorting {
  String? get value {
    switch (this) {
      case ESRPlaylistFollowersSorting.id:
        return 'id';
      case ESRPlaylistFollowersSorting.userFirstName:
        return 'user__first_name';
      case ESRPlaylistFollowersSorting.userLastName:
        return 'user__last_name';
      case ESRPlaylistFollowersSorting.userNativeFirstName:
        return 'user__native_first_name';
      case ESRPlaylistFollowersSorting.userNativeLastName:
        return 'user__native_last_name';
      case ESRPlaylistFollowersSorting.userUsername:
        return 'user__username';
      case ESRPlaylistFollowersSorting.userFollowers:
        return 'user__follow_count';
      case ESRPlaylistFollowersSorting.created:
        return 'created';
    }
  }
}
