# App Config Manager

A Flutter package for managing application configuration with support for multiple environments (UAT, PROD) and a user-friendly configuration UI.

## Features

- 🔄 Easy environment switching between UAT and PROD
- 🎨 Material 3 design with a modern bottom sheet UI
- 🔒 Secure configuration storage
- 📱 Support for both mobile and web platforms
- 🎯 Provider-based state management
- 🔍 Debug mode toggle
- 📝 Additional configuration support
- 🎮 Customizable configuration UI

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  app_config_manager: ^1.0.0
```

## Usage

1. First, initialize the configuration manager with your default configuration:

```dart
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
```

2. Use the configuration in your app:

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppConfigNotifier>(
      builder: (context, configNotifier, child) {
        final config = configNotifier.config;
        return Text('Current Base URL: ${config.currentConfig.baseUrl}');
      },
    );
  }
}
```

3. Show the configuration UI:

```dart
IconButton(
  icon: const Icon(Icons.settings),
  onPressed: () {
    showAppConfigBottomSheet(
      context: context,
      onConfigChanged: (config) {
        // Optional callback when configuration changes
      },
    );
  },
)
```

## Configuration

### AppConfig

The main configuration class that holds all environment configurations:

```dart
final config = AppConfig(
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
```

### EnvironmentConfig

Configuration for a specific environment:

```dart
final uatConfig = EnvironmentConfig(
  baseUrl: 'https://api-uat.example.com',
  additionalConfig: {
    'apiVersion': 'v1',
    'timeout': 30000,
    'debugMode': true,
  },
);
```

## State Management

The package uses Provider for state management. The `AppConfigNotifier` class manages the configuration state and notifies listeners when changes occur.

```dart
// Access the configuration
final configNotifier = context.read<AppConfigNotifier>();
final config = configNotifier.config;

// Listen to changes
Consumer<AppConfigNotifier>(
  builder: (context, configNotifier, child) {
    final config = configNotifier.config;
    return Text('Current Environment: ${config.currentEnvironment}');
  },
)
```

### Alternative Usage Methods

#### 1. Using context.watch() (For Automatic Rebuilds)

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Automatically rebuilds when config changes
    final config = context.watch<AppConfigNotifier>().config;
    
    return Column(
      children: [
        Text('Environment: ${config.currentEnvironment}'),
        Text('Base URL: ${config.currentConfig.baseUrl}'),
        Text('Debug Mode: ${config.currentConfig.additionalConfig['debugMode']}'),
      ],
    );
  }
}
```

#### 2. Using context.read() (For One-time Reads)

```dart
void onButtonPressed(BuildContext context) {
  // Access configuration once (doesn't rebuild on changes)
  final configNotifier = context.read<AppConfigNotifier>();
  final config = configNotifier.config;
  print('Current Base URL: ${config.currentConfig.baseUrl}');
}
```

#### 3. Using Provider.of (Alternative Syntax)

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // listen: true means it will rebuild on changes
    final config = Provider.of<AppConfigNotifier>(context, listen: true).config;
    
    return Text('Current Environment: ${config.currentEnvironment}');
  }
}
```

## UI Customization

The configuration bottom sheet can be customized:

```dart
showAppConfigBottomSheet(
  context: context,
  onConfigChanged: (config) {
    // Handle configuration changes
  },
  closeIcon: Icons.close, // Custom close icon
);
```

## Platform Support

The package supports both mobile and web platforms. For web support, add the following to your `web/index.html`:

```html
<script src="flutter_web_plugins.js" defer></script>
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

