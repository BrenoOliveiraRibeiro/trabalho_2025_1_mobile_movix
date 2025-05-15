class UserSettings {
  final bool isDarkMode;

  UserSettings({required this.isDarkMode});

  Map<String, dynamic> toJson() => {'isDarkMode': isDarkMode};

  factory UserSettings.fromJson(Map<String, dynamic> json) =>
      UserSettings(isDarkMode: json['isDarkMode'] ?? false);
}
