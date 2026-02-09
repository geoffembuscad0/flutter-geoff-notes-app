import 'package:shared_preferences/shared_preferences.dart';

import '../../app/api_client/api_client.dart';
import 'connectivity_service.dart';
import 'shared_preferences_service.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();

  static ApiClient get apiClient => _instance._apiClient;

  static ConnectivityService get connectivity => _instance._connectivityService;
  static SharedPreferencesService get sharedPrefs =>
      _instance._sharedPreferencesService;

  late final ConnectivityService _connectivityService;

  late final ApiClient _apiClient;
  late final SharedPreferencesService _sharedPreferencesService;

  factory ServiceLocator() => _instance;

  ServiceLocator._internal();

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _sharedPreferencesService = SharedPreferencesService(prefs);
    _connectivityService = ConnectivityService();
    _apiClient = ApiClient();
  }
}
