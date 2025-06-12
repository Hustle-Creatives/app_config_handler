import 'app_config_manager_platform_interface.dart';

/// A stub implementation of the AppConfigManagerPlatform that does nothing.
/// This is used when the web implementation is not available.
class AppConfigManagerStub extends AppConfigManagerPlatform {
  /// Constructs a AppConfigManagerStub
  AppConfigManagerStub();

  static void registerWith() {
    AppConfigManagerPlatform.instance = AppConfigManagerStub();
  }

  @override
  Future<String?> getPlatformVersion() async {
    return null;
  }
}
