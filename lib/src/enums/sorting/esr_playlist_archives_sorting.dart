enum ESRPlaylistArchivesSorting {
  id,
  playlistName,
  playlistIsPublic,
  playlistUser,
  playlistFollowCount,
  playlistLikeCount,
  playlistShareCount,
  playlistCreated,
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
  created
}

extension ESRPlaylistArchivesSortingExtension on ESRPlaylistArchivesSorting {
  String? get value {
    switch (this) {
      case ESRPlaylistArchivesSorting.id:
        return 'id';
      case ESRPlaylistArchivesSorting.playlistName:
        return 'playlist__name';
      case ESRPlaylistArchivesSorting.playlistIsPublic:
        return 'playlist__is_public';
      case ESRPlaylistArchivesSorting.playlistUser:
        return 'playlist__user__id';
      case ESRPlaylistArchivesSorting.playlistFollowCount:
        return 'playlist__follow_count';
      case ESRPlaylistArchivesSorting.playlistLikeCount:
        return 'playlist__likes_count';
      case ESRPlaylistArchivesSorting.playlistShareCount:
        return 'playlist__shares_count';
      case ESRPlaylistArchivesSorting.playlistCreated:
        return 'playlist__created';
      case ESRPlaylistArchivesSorting.archiveName:
        return 'archive__translations__name';
      case ESRPlaylistArchivesSorting.archiveDescription:
        return 'archive__translations__description';
      case ESRPlaylistArchivesSorting.archiveDuration:
        return "archive__translations__duration";
      case ESRPlaylistArchivesSorting.archiveProduction:
        return "archive__production__id";
      case ESRPlaylistArchivesSorting.archiveLanguage:
        return "archive__lang__id";
      case ESRPlaylistArchivesSorting.archiveBroadcastDay:
        return "archive__broadcast_day";
      case ESRPlaylistArchivesSorting.archiveStartTime:
        return "archive__start_time";
      case ESRPlaylistArchivesSorting.archiveEndTime:
        return "archive__end_time";
      case ESRPlaylistArchivesSorting.archiveDisabled:
        return "archive__disabled";
      case ESRPlaylistArchivesSorting.archiveAverageRating:
        return "archive__average_rating";
      case ESRPlaylistArchivesSorting.archiveRatingsCount:
        return "archive__ratings_count";
      case ESRPlaylistArchivesSorting.archiveLikesCount:
        return "archive__likes_count";
      case ESRPlaylistArchivesSorting.archiveListensCount:
        return "archive__listens_count";
      case ESRPlaylistArchivesSorting.archiveSharesCount:
        return "archive__shares_count";
      case ESRPlaylistArchivesSorting.archiveCommentsCount:
        return "archive__comments_count";
      case ESRPlaylistArchivesSorting.archiveCreated:
        return "archive__created";
      case ESRPlaylistArchivesSorting.created:
        return "created";
    }
  }
}
