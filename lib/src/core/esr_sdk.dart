import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRSDK {
  static final ESRSDK _instance = ESRSDK._internal();
  ESRSDK._internal();
  factory ESRSDK() => _instance;

  late String apiKey;
  late ESREnvironments env;
  late String appVersion;
  late String sdkVersion;

  static Future<void> init({
    required String apiKey,
    required ESREnvironments env,
    required String appVersion
  }) async {
    final instance = _instance;
    instance.apiKey = apiKey;
    instance.env = env;
    instance.appVersion = appVersion;
    instance.sdkVersion = "1.1.0";

    print('ESR SDK initialised ✅');
  }

  void updateEnv(ESREnvironments newEnv) {
    env = newEnv;
    print('ESR SDK env updated to $newEnv 🔁');
  }
}