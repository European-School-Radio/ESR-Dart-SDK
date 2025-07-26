import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRSDK {
  static final ESRSDK _instance = ESRSDK._internal();
  ESRSDK._internal();
  factory ESRSDK() => _instance;

  late final String apiKey;
  late final ESREnvironments env;

  static Future<void> init({
    required String apiKey,
    required ESREnvironments env
  }) async {
    final instance = _instance;
    instance.apiKey = apiKey;
    instance.env = env;

    print('ESR SDK initialised ✅');
  }
}