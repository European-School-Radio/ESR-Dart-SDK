enum ESRProductionFollowersSorting {
  id,
  firstName,
  lastName,
  nativeFirstName,
  nativeLastName,
  created
}

extension ESRProductionFollowersSortingExtension on ESRProductionFollowersSorting {
  String? get value {
    switch (this) {
      case ESRProductionFollowersSorting.id:
        return 'id';
      case ESRProductionFollowersSorting.firstName:
        return 'user__first_name';
      case ESRProductionFollowersSorting.lastName:
        return 'user__last_name';
      case ESRProductionFollowersSorting.nativeFirstName:
        return 'user__native_first_name';
      case ESRProductionFollowersSorting.nativeLastName:
        return 'user__native_last_name';
      case ESRProductionFollowersSorting.created:
        return 'created';
    }
  }
}
