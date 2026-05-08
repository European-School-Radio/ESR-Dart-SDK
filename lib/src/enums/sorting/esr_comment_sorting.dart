enum ESRCommentSorting {
  id,
  userID,
  userFirstName,
  userLastName,
  userNativeFirstName,
  userNativeLastName,
  userUsername,
  userFollowers,
  userCreated,
  archiveID,
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
  audioTimestamp
}

extension ESRCommentSortingExtension on ESRCommentSorting {
  String? get value {
    switch (this) {
      case ESRCommentSorting.id:
        return "id";
      case ESRCommentSorting.userID:
        return "user__id";
      case ESRCommentSorting.userFirstName:
        return "user__first_name";
      case ESRCommentSorting.userLastName:
        return "user__last_name";
      case ESRCommentSorting.userNativeFirstName:
        return "user__native_first_name";
      case ESRCommentSorting.userNativeLastName:
        return "user__native_last_name";
      case ESRCommentSorting.userUsername:
        return "user__username";
      case ESRCommentSorting.userFollowers:
        return "user__follow_count";
      case ESRCommentSorting.userCreated:
        return "user__created";
      case ESRCommentSorting.archiveID:
        return "archive__id";
      case ESRCommentSorting.archiveName:
        return "archive__translations__name";
      case ESRCommentSorting.archiveDescription:
        return "archive__translations__description";
      case ESRCommentSorting.archiveDuration:
        return "archive__translations__duration";
      case ESRCommentSorting.archiveProduction:
        return "archive__production__id";
      case ESRCommentSorting.archiveLanguage:
        return "archive__lang__id";
      case ESRCommentSorting.archiveBroadcastDay:
        return "archive__broadcast_day";
      case ESRCommentSorting.archiveStartTime:
        return "archive__start_time";
      case ESRCommentSorting.archiveEndTime:
        return "archive__end_time";
      case ESRCommentSorting.archiveDisabled:
        return "archive__disabled";
      case ESRCommentSorting.archiveAverageRating:
        return "archive__average_rating";
      case ESRCommentSorting.archiveRatingsCount:
        return "archive__ratings_count";
      case ESRCommentSorting.archiveLikesCount:
        return "archive__likes_count";
      case ESRCommentSorting.archiveListensCount:
        return "archive__listens_count";
      case ESRCommentSorting.archiveSharesCount:
        return "archive__shares_count";
      case ESRCommentSorting.archiveCommentsCount:
        return "archive__comments_count";
      case ESRCommentSorting.archiveCreated:
        return "archive__created";
      case ESRCommentSorting.audioTimestamp:
        return "audio_timestamp_duration";
    }
  }
}