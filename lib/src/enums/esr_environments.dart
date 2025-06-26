enum EsrEnvironments {
  production,
  test
}

extension EsrEnvironmentsExtension on EsrEnvironments {
  String? get value {
    switch (this){
      case EsrEnvironments.production:
        return "https://api.europeanschoolradio.eu";
      case EsrEnvironments.test:
        return 'https://api-new.europeanschoolradio.eu';
      }
  }
}
