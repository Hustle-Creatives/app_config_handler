import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'app_config_manager_method_channel.dart';

abstract class AppConfigManagerPlatform extends PlatformInterface {
  /// Constructs a AppConfigManagerPlatform.
  AppConfigManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static AppConfigManagerPlatform _instance = MethodChannelAppConfigManager();

  /// The default instance of [AppConfigManagerPlatform] to use.
  ///
  /// Defaults to [MethodChannelAppConfigManager].
  static AppConfigManagerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AppConfigManagerPlatform] when
  /// they register themselves.
  static set instance(AppConfigManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
