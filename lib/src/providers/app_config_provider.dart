import 'package:flutter/foundation.dart';
import '../models/app_config.dart';
import '../config_manager.dart';

class AppConfigNotifier extends ChangeNotifier {
  final ConfigManager _configManager;
  late AppConfig _config;

  AppConfigNotifier(this._configManager) {
    _config = _configManager.config;
    _configManager.addListener(_onConfigChanged);
  }

  AppConfig get config => _config;

  void _onConfigChanged(AppConfig newConfig) {
    _config = newConfig;
    notifyListeners();
  }

  @override
  void dispose() {
    _configManager.removeListener(_onConfigChanged);
    super.dispose();
  }
}
