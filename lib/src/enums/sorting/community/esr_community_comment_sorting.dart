enum ESRCommunityCommentSorting {
  id,
  date
}

extension ESRCommunityCommentSortingExtension on ESRCommunityCommentSorting {
  String? get value {
    switch (this) {
      case ESRCommunityCommentSorting.id:
        return "id";
      case ESRCommunityCommentSorting.date:
        return "date";
    }
  }
}