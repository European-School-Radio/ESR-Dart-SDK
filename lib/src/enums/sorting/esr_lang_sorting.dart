enum ESRLangSorting {
  id,
  name,
  nativeName,
  code,
  flag,
  created
}

extension ESRLangSortingExtension on ESRLangSorting {
  String? get value {
    switch (this) {
      case ESRLangSorting.id:
        return 'id';
      case ESRLangSorting.name:
        return 'translations__name';
      case ESRLangSorting.nativeName:
        return 'translations__native_name';
      case ESRLangSorting.code:
        return 'code';
      case ESRLangSorting.flag:
        return 'flag';
      case ESRLangSorting.created:
        return 'created';
    }
  }
}
