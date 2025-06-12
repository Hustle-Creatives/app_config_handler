import 'package:flutter/material.dart';
import '../models/app_config.dart';
import '../config_manager.dart';

/// Shows a bottom sheet for managing app configuration.
///
/// [context] The build context.
/// [onConfigChanged] Optional callback when configuration changes.
/// [icon] Optional custom icon for the close button.
void showAppConfigBottomSheet({
  required BuildContext context,
  Function(AppConfig)? onConfigChanged,
  Icon? closeIcon,
}) {
  final configManager = ConfigManager();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder:
        (context) => StatefulBuilder(
          builder: (context, setState) {
            String selectedEnv = configManager.config.currentEnvironment;
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with title and close button
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Environment Settings',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: closeIcon ?? const Icon(Icons.close),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Content
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Edge-to-edge segmented button
                        SizedBox(
                          width: double.infinity,
                          child: SegmentedButton<String>(
                            segments: const [
                              ButtonSegment(value: 'uat', label: Text('UAT')),
                              ButtonSegment(value: 'prod', label: Text('PROD')),
                            ],
                            selected: {selectedEnv},
                            onSelectionChanged: (Set<String> selection) {
                              final newEnv = selection.first;
                              final newConfig = AppConfig(
                                uat: configManager.config.uat,
                                prod: configManager.config.prod,
                                currentEnvironment: newEnv,
                              );
                              configManager.updateConfig(newConfig);
                              onConfigChanged?.call(newConfig);
                              setState(() {
                                selectedEnv = newEnv;
                              });
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                const Size.fromHeight(48),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Configuration details
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Current Base URL:',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                configManager.config.currentConfig.baseUrl,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
  );
}
