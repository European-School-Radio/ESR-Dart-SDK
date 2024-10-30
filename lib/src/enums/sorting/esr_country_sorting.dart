enum ESRCountrySorting {
  id,
  name,
  code,
  created
}

extension ESRCountrySortingExtension on ESRCountrySorting {
  String? get value {
    switch (this) {
      case ESRCountrySorting.id:
        return 'id';
      case ESRCountrySorting.name:
        return 'name';
      case ESRCountrySorting.code:
        return 'code';
      case ESRCountrySorting.created:
        return 'created';
      default:
        return null;
    }
  }
}
