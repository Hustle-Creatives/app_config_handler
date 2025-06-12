import 'package:flutter/material.dart';
import 'package:app_config_manager/app_config_manager.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Create default configuration
  final defaultConfig = AppConfig(
    uat: EnvironmentConfig(
      baseUrl: 'https://api-uat.example.com',
      additionalConfig: {
        'apiVersion': 'v1',
        'timeout': 30000,
        'debugMode': true,
      },
    ),
    prod: EnvironmentConfig(
      baseUrl: 'https://api.example.com',
      additionalConfig: {
        'apiVersion': 'v1',
        'timeout': 30000,
        'debugMode': false,
      },
    ),
  );

  final configManager = ConfigManager();
  await configManager.initialize(defaultConfig: defaultConfig);

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppConfigNotifier(configManager),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Config Manager Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'App Config Manager Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'App Settings',
            onPressed: () {
              showAppConfigBottomSheet(
                context: context,
                onConfigChanged: (config) {
                  print('config: ${config.currentConfig.baseUrl}');
                  // The provider will handle the state update
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<AppConfigNotifier>(
        builder: (context, configNotifier, child) {
          final config = configNotifier.config;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Current Environment:',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  config.currentEnvironment.toUpperCase(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Base URL:',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  config.currentConfig.baseUrl,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Additional Config:',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  config.currentConfig.additionalConfig.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
