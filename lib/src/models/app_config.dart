import 'environment_config.dart';

class AppConfig {
  final EnvironmentConfig uat;
  final EnvironmentConfig prod;
  String currentEnvironment;

  AppConfig({
    required this.uat,
    required this.prod,
    this.currentEnvironment = 'prod',
  });

  EnvironmentConfig get currentConfig =>
      currentEnvironment == 'prod' ? prod : uat;

  AppConfig copyWith({
    EnvironmentConfig? uat,
    EnvironmentConfig? prod,
    String? currentEnvironment,
  }) {
    return AppConfig(
      uat: uat ?? this.uat,
      prod: prod ?? this.prod,
      currentEnvironment: currentEnvironment ?? this.currentEnvironment,
    );
  }

  Map<String, dynamic> toJson() => {
    'uat': uat.toJson(),
    'prod': prod.toJson(),
    'currentEnvironment': currentEnvironment,
  };

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      uat: EnvironmentConfig.fromJson(json['uat'] as Map<String, dynamic>),
      prod: EnvironmentConfig.fromJson(json['prod'] as Map<String, dynamic>),
      currentEnvironment: json['currentEnvironment'] as String,
    );
  }
}
