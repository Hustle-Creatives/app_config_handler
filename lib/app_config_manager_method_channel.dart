import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'app_config_manager_platform_interface.dart';

/// An implementation of [AppConfigManagerPlatform] that uses method channels.
class MethodChannelAppConfigManager extends AppConfigManagerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('app_config_manager');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }
}
