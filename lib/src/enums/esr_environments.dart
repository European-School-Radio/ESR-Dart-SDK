enum ESREnvironments {
  production,
  test,
  youthRadio
}

extension EsrEnvironmentsExtension on ESREnvironments {
  String? get value {
    switch (this){
      case ESREnvironments.production:
        return "https://api.europeanschoolradio.eu";
      case ESREnvironments.test:
        return 'https://api-new.europeanschoolradio.eu';
      case ESREnvironments.youthRadio:
        return "https://api.europeanschoolradio.eu";
      }
  }
}
