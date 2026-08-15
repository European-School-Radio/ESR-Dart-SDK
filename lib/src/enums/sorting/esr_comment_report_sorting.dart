enum ESRCommentReportSorting {
  id,
  comment,
  reportReason,
  user,
  updatedBy,
  reportClosed,
  created
}

extension ESRCommentReportSortingExtension on ESRCommentReportSorting {
  String? get value {
    switch (this) {
      case ESRCommentReportSorting.id:
        return 'id';
      case ESRCommentReportSorting.comment:
        return "comment__id";
      case ESRCommentReportSorting.reportReason:
        return 'report_reason__id';
      case ESRCommentReportSorting.user:
        return 'user__id';
      case ESRCommentReportSorting.updatedBy:
        return 'updated_by__id';
      case ESRCommentReportSorting.reportClosed:
        return 'report_closed';
      case ESRCommentReportSorting.created:
        return 'created';
    }
  }
}
