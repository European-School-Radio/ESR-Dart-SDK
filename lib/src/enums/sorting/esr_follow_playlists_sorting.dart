enum ESRFollowPlaylistsSorting {
  id,
  userID,
  userFirstName,
  userLastName,
  userNativeFirstName,
  userNativeLastName,
  userUsername,
  userFollowers,
  userCreated,
  playlistID,
  playlistName,
  playlistIsPublic,
  playlistFollowCount,
  playlistLikeCount,
  playlistShareCount,
  playlistCreated,
  created
}

extension ESRFollowPlaylistsSortingExtension on ESRFollowPlaylistsSorting {
  String? get value {
    switch (this) {
      case ESRFollowPlaylistsSorting.id:
        return 'id';
      case ESRFollowPlaylistsSorting.userID:
        return "user__id";
      case ESRFollowPlaylistsSorting.userFirstName:
        return "user__first_name";
      case ESRFollowPlaylistsSorting.userLastName:
        return "user__last_name";
      case ESRFollowPlaylistsSorting.userNativeFirstName:
        return "user__native_first_name";
      case ESRFollowPlaylistsSorting.userNativeLastName:
        return "user__native_last_name";
      case ESRFollowPlaylistsSorting.userUsername:
        return "user__username";
      case ESRFollowPlaylistsSorting.userFollowers:
        return "user__follow_count";
      case ESRFollowPlaylistsSorting.userCreated:
        return "user__created";
      case ESRFollowPlaylistsSorting.playlistID:
        return "playlist__id";
      case ESRFollowPlaylistsSorting.playlistName:
        return "playlist__name";
      case ESRFollowPlaylistsSorting.playlistIsPublic:
        return "playlist__is_public";
      case ESRFollowPlaylistsSorting.playlistFollowCount:
        return "playlist__follow_count";
      case ESRFollowPlaylistsSorting.playlistLikeCount:
        return "playlist__likes_count";
      case ESRFollowPlaylistsSorting.playlistShareCount:
        return "playlist__shares_count";
      case ESRFollowPlaylistsSorting.playlistCreated:
        return "playlist__created";
      case ESRFollowPlaylistsSorting.created:
        return "created";
    }
  }
}