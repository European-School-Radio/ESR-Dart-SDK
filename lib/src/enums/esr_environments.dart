enum ESREnvironments {
  production,
  test,
  youthRadio
}

extension EsrEnvironmentsExtension on ESREnvironments {
  String? get value {
    switch (this){
      case ESREnvironments.production:
        return "https://europeanschoolradio.eu";
      case ESREnvironments.test:
        return 'https://next-dev.europeanschoolradio.eu';
      case ESREnvironments.youthRadio:
        return "https://youthradio.eu";
      }
  }

  String? get requestApplication {
    switch (this){
      case ESREnvironments.production:
        return "european_school_radio";
      case ESREnvironments.test:
        return "european_school_radio";
      case ESREnvironments.youthRadio:
        return "youth_radio";
    }
  }
}
