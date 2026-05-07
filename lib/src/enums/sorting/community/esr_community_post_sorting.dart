enum ESRCommunityPostSorting {
  id,
  title,
  slug,
  date
}

extension ESRCommunityPostSortingExtension on ESRCommunityPostSorting {
  String? get value {
    switch (this) {
      case ESRCommunityPostSorting.id:
        return "id";
      case ESRCommunityPostSorting.title:
        return "title";
      case ESRCommunityPostSorting.slug:
        return "slug";
      case ESRCommunityPostSorting.date:
        return "date";
    }
  }
}