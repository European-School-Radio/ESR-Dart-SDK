enum ESRArchiveHistoryListenSorting {
  id,
  archiveName,
  archiveDescription,
  archiveDuration,
  archiveProduction,
  archiveLanguage,
  archiveBroadcastDay,
  archiveStartTime,
  archiveEndTime,
  archiveDisabled,
  archiveAverageRating,
  archiveRatingsCount,
  archiveLikesCount,
  archiveListensCount,
  archiveSharesCount,
  archiveCommentsCount,
  archiveCreated,
  archiveUpdated,
  userID,
  userFirstName,
  userLastName,
  userNativeFirstName,
  userNativeLastName,
  userUsername,
  userFollowers,
  userCreated,
  totalTime,
  created
}

extension ESRArchiveHistoryListenSortingExtension on ESRArchiveHistoryListenSorting {
  String? get value {
    switch (this) {
      case ESRArchiveHistoryListenSorting.id:
        return 'id';
      case ESRArchiveHistoryListenSorting.archiveName:
        return 'archive__translations__name';
      case ESRArchiveHistoryListenSorting.archiveDescription:
        return 'archive__translations__description';
      case ESRArchiveHistoryListenSorting.archiveDuration:
        return "archive__translations__duration";
      case ESRArchiveHistoryListenSorting.archiveProduction:
        return "archive__production__id";
      case ESRArchiveHistoryListenSorting.archiveLanguage:
        return "archive__lang__id";
      case ESRArchiveHistoryListenSorting.archiveBroadcastDay:
        return "archive__broadcast_day";
      case ESRArchiveHistoryListenSorting.archiveStartTime:
        return "archive__start_time";
      case ESRArchiveHistoryListenSorting.archiveEndTime:
        return "archive__end_time";
      case ESRArchiveHistoryListenSorting.archiveDisabled:
        return "archive__disabled";
      case ESRArchiveHistoryListenSorting.archiveAverageRating:
        return "archive__average_rating";
      case ESRArchiveHistoryListenSorting.archiveRatingsCount:
        return "archive__ratings_count";
      case ESRArchiveHistoryListenSorting.archiveLikesCount:
        return "archive__likes_count";
      case ESRArchiveHistoryListenSorting.archiveListensCount:
        return "archive__listens_count";
      case ESRArchiveHistoryListenSorting.archiveSharesCount:
        return "archive__shares_count";
      case ESRArchiveHistoryListenSorting.archiveCommentsCount:
        return "archive__comments_count";
      case ESRArchiveHistoryListenSorting.archiveCreated:
        return "archive__created";
      case ESRArchiveHistoryListenSorting.archiveUpdated:
        return "archive__updated";
      case ESRArchiveHistoryListenSorting.userID:
        return 'user__id';
      case ESRArchiveHistoryListenSorting.userFirstName:
        return 'user__first_name';
      case ESRArchiveHistoryListenSorting.userLastName:
        return 'user__last_name';
      case ESRArchiveHistoryListenSorting.userNativeFirstName:
        return 'user__native_first_name';
      case ESRArchiveHistoryListenSorting.userNativeLastName:
        return 'user__native_last_name';
      case ESRArchiveHistoryListenSorting.userUsername:
        return 'user__username';
      case ESRArchiveHistoryListenSorting.userFollowers:
        return "user__follow_count";
      case ESRArchiveHistoryListenSorting.userCreated:
        return "user__created";
      case ESRArchiveHistoryListenSorting.totalTime:
        return 'total_time';
      case ESRArchiveHistoryListenSorting.created:
        return 'created';
    }
  }
}
