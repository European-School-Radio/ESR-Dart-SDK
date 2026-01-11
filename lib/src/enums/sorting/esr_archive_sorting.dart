enum ESRArchiveSorting {
  id,
  name,
  description,
  duration,
  production,
  language,
  broadcastDay,
  startTime,
  endTime,
  disabled,
  averageRating,
  ratingsCount,
  likesCount,
  listensCount,
  sharesCount,
  commentsCount,
  created,
  updated,
  relativity
}

extension ESRArchiveSortingExtension on ESRArchiveSorting {
  String? get value {
    switch (this) {
      case ESRArchiveSorting.id:
        return 'id';
      case ESRArchiveSorting.name:
        return 'translations__name';
      case ESRArchiveSorting.description:
        return 'translations__description';
      case ESRArchiveSorting.duration:
        return "translations__duration";
      case ESRArchiveSorting.production:
        return "production__id";
      case ESRArchiveSorting.language:
        return "lang__id";
      case ESRArchiveSorting.broadcastDay:
        return "broadcast_day";
      case ESRArchiveSorting.startTime:
        return "start_time";
      case ESRArchiveSorting.endTime:
        return "end_time";
      case ESRArchiveSorting.disabled:
        return "disabled";
      case ESRArchiveSorting.averageRating:
        return "average_rating";
      case ESRArchiveSorting.ratingsCount:
        return "ratings_count";
      case ESRArchiveSorting.likesCount:
        return "likes_count";
      case ESRArchiveSorting.listensCount:
        return "listens_count";
      case ESRArchiveSorting.sharesCount:
        return "shares_count";
      case ESRArchiveSorting.commentsCount:
        return "comments_count";
      case ESRArchiveSorting.created:
        return "created";
      case ESRArchiveSorting.updated:
        return "updated";
      case ESRArchiveSorting.relativity:
          return "relativity";
    }
  }
}
