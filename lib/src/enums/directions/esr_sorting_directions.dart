enum ESRSortingDirections {
  asc,
  desc
}

extension EsrSortingDirectionsExtension on ESRSortingDirections {
  String? get value {
    switch (this){
      case ESRSortingDirections.asc:
        return "ASC";
      case ESRSortingDirections.desc:
        return 'DESC';
      }
  }
}
