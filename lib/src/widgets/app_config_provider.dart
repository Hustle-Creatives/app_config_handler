import 'package:flutter/material.dart';
import '../models/app_config.dart';
import '../config_manager.dart';

class AppConfigProvider extends StatefulWidget {
  final Widget child;
  final Function(AppConfig)? onConfigChanged;

  const AppConfigProvider({
    super.key,
    required this.child,
    this.onConfigChanged,
  });

  @override
  State<AppConfigProvider> createState() => _AppConfigProviderState();
}

class _AppConfigProviderState extends State<AppConfigProvider> {
  late final ConfigManager _configManager;

  @override
  void initState() {
    super.initState();
    _configManager = ConfigManager();
    if (widget.onConfigChanged != null) {
      _configManager.addListener(widget.onConfigChanged!);
    }
  }

  @override
  void dispose() {
    if (widget.onConfigChanged != null) {
      _configManager.removeListener(widget.onConfigChanged!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
