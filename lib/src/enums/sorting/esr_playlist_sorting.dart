enum ESRPlaylistSorting {
  id,
  name,
  isPublic,
  user,
  followCount,
  likeCount,
  shareCount,
  created
}

extension ESRPlaylistSortingExtension on ESRPlaylistSorting {
  String? get value {
    switch (this) {
      case ESRPlaylistSorting.id:
        return 'id';
      case ESRPlaylistSorting.name:
        return 'name';
      case ESRPlaylistSorting.isPublic:
        return 'is_public';
      case ESRPlaylistSorting.user:
        return 'user__id';
      case ESRPlaylistSorting.followCount:
        return 'follow_count';
      case ESRPlaylistSorting.likeCount:
        return 'likes_count';
      case ESRPlaylistSorting.shareCount:
        return 'shares_count';
      case ESRPlaylistSorting.created:
        return 'created';
    }
  }
}
