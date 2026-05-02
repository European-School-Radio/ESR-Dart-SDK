enum ESRPlaylistFollowersSorting {
  id,
  userFirstName,
  userFastName,
  userNativeFirstName,
  userNativeLastName,
  created
}

extension ESRPlaylistFollowersSortingExtension on ESRPlaylistFollowersSorting {
  String? get value {
    switch (this) {
      case ESRPlaylistFollowersSorting.id:
        return 'id';
      case ESRPlaylistFollowersSorting.userFirstName:
        return 'user__first_name';
      case ESRPlaylistFollowersSorting.userFastName:
        return 'user__last_name';
      case ESRPlaylistFollowersSorting.userNativeFirstName:
        return 'user__native_first_name';
      case ESRPlaylistFollowersSorting.userNativeLastName:
        return 'user__native_last_name';
      case ESRPlaylistFollowersSorting.created:
        return 'created';
    }
  }
}
