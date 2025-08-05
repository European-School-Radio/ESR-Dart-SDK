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
        return "https://europeanschoolradio.eu";
      }
  }
}
