enum ESRPlaylistFollowersSorting {
  id,
  firstName,
  lastName,
  nativeFirstName,
  nativeLastName,
  created
}

extension ESRPlaylistFollowersSortingExtension on ESRPlaylistFollowersSorting {
  String? get value {
    switch (this) {
      case ESRPlaylistFollowersSorting.id:
        return 'id';
      case ESRPlaylistFollowersSorting.firstName:
        return 'user__first_name';
      case ESRPlaylistFollowersSorting.lastName:
        return 'user__last_name';
      case ESRPlaylistFollowersSorting.nativeFirstName:
        return 'user__native_first_name';
      case ESRPlaylistFollowersSorting.nativeLastName:
        return 'user__native_last_name';
      case ESRPlaylistFollowersSorting.created:
        return 'created';
    }
  }
}
