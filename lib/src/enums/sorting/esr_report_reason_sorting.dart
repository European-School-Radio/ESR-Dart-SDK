enum ESRReportReasonSorting {
  id,
  name,
  needsDescription,
  created
}

extension ESRReportReasonSortingExtension on ESRReportReasonSorting {
  String? get value {
    switch (this) {
      case ESRReportReasonSorting.id:
        return 'id';
      case ESRReportReasonSorting.name:
        return 'translations__name';
      case ESRReportReasonSorting.needsDescription:
        return 'needs_description';
      case ESRReportReasonSorting.created:
        return 'created';
    }
  }
}
