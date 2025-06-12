import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/app_config.dart';
import 'models/environment_config.dart';

class ConfigManager {
  static final ConfigManager _instance = ConfigManager._internal();
  factory ConfigManager() => _instance;
  ConfigManager._internal();

  static const String _configKey = 'app_config';
  late AppConfig _config;
  final List<Function(AppConfig)> _listeners = [];
  SharedPreferences? _prefs;
  bool _isInitialized = false;
  AppConfig? _defaultConfig;

  AppConfig get config => _config;

  Future<void> initialize({required AppConfig defaultConfig}) async {
    if (_isInitialized) return;

    _defaultConfig = defaultConfig;
    _prefs = await SharedPreferences.getInstance();
    await _loadConfig();
    _isInitialized = true;
  }

  Future<void> _loadConfig() async {
    final savedConfig = _prefs?.getString(_configKey);

    if (savedConfig != null) {
      try {
        _config = AppConfig.fromJson(json.decode(savedConfig));
      } catch (e) {
        if (_defaultConfig == null) {
          throw StateError(
            'No default configuration provided and stored configuration is invalid.',
          );
        }
        _config = _defaultConfig!;
      }
    } else {
      if (_defaultConfig == null) {
        throw StateError('No default configuration provided.');
      }
      _config = _defaultConfig!;
    }
    await _saveConfig();
  }

  Future<void> _saveConfig() async {
    if (_prefs == null || _config == null) return;
    await _prefs!.setString(_configKey, json.encode(_config.toJson()));
  }

  Future<void> updateConfig(AppConfig newConfig) async {
    _config = newConfig;
    await _saveConfig();
    _notifyListeners();
  }

  void addListener(Function(AppConfig) listener) {
    _listeners.add(listener);
  }

  void removeListener(Function(AppConfig) listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners() {
    for (final listener in _listeners) {
      listener(_config);
    }
  }

  Future<void> switchEnvironment(String environment) async {
    if (!_isInitialized || _config == null) return;
    if (environment != 'uat' && environment != 'prod') return;

    final newConfig = _config.copyWith(currentEnvironment: environment);
    await updateConfig(newConfig);
  }

  Future<void> updateEnvironmentConfig(
    String environment,
    EnvironmentConfig newConfig,
  ) async {
    if (!_isInitialized || _config == null) return;
    if (environment != 'uat' && environment != 'prod') return;

    final newAppConfig = _config.copyWith(
      uat: environment == 'uat' ? newConfig : _config.uat,
      prod: environment == 'prod' ? newConfig : _config.prod,
    );
    await updateConfig(newAppConfig);
  }

  Future<void> reset() async {
    if (!_isInitialized || _defaultConfig == null) return;
    _config = _defaultConfig!;
    await _saveConfig();
    _notifyListeners();
  }
}
