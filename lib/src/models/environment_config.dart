class EnvironmentConfig {
  final String baseUrl;
  final Map<String, dynamic> additionalConfig;

  EnvironmentConfig({required this.baseUrl, this.additionalConfig = const {}});

  Map<String, dynamic> toJson() => {
    'baseUrl': baseUrl,
    'additionalConfig': additionalConfig,
  };

  factory EnvironmentConfig.fromJson(Map<String, dynamic> json) {
    return EnvironmentConfig(
      baseUrl: json['baseUrl'] as String,
      additionalConfig: Map<String, dynamic>.from(
        json['additionalConfig'] as Map,
      ),
    );
  }
}
