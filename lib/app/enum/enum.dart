enum AppThemeMode {
  light,
  dark,
  system;

  String toJson() => name;
  static AppThemeMode fromJson(String json) => values.byName(json);
}
