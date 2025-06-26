enum ESRSchoolSorting {
  id,
  name,
  description,
  nativeName,
  nativeDescription,
  schoolType,
  country,
  city,
  address,
  zipCode,
  latitude,
  longitude,
  officialNumber,
  email,
  phone,
  followCount,
  sharesCount,
  disabled,
  created
}

extension ESRCountrySortingExtension on ESRSchoolSorting {
  String? get value {
    switch (this) {
      case ESRSchoolSorting.id:
        return 'id';
      case ESRSchoolSorting.name:
        return 'name';
      case ESRSchoolSorting.description:
        return 'description';
      case ESRSchoolSorting.nativeName:
        return 'native_name';
      case ESRSchoolSorting.nativeDescription:
        return 'native_description';
      case ESRSchoolSorting.schoolType:
        return 'school_tpe__id';
      case ESRSchoolSorting.country:
        return 'country__id';
      case ESRSchoolSorting.city:
        return 'city';
      case ESRSchoolSorting.address:
        return 'address';
      case ESRSchoolSorting.zipCode:
        return 'zip_code';
      case ESRSchoolSorting.latitude:
        return 'latitude';
      case ESRSchoolSorting.longitude:
        return 'longitude';
      case ESRSchoolSorting.officialNumber:
        return 'official_number';
      case ESRSchoolSorting.email:
        return 'email';
      case ESRSchoolSorting.phone:
        return 'phone';
      case ESRSchoolSorting.followCount:
        return 'follow_count';
      case ESRSchoolSorting.sharesCount:
        return 'shares_count';
      case ESRSchoolSorting.disabled:
        return 'disabled';
      case ESRSchoolSorting.created:
        return 'created';
    }
  }
}
