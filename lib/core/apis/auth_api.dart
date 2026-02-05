import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/app/utils/logger_utils.dart';

import '../../app/routes/api_routes.dart';
import '../../app/services/service_locator.dart';

class AuthApi {
  final _apiClient = ServiceLocator.apiClient;
  Future<void> login(String email, String password) async {
    try {
      _apiClient.post(ApiRoutes.login, data: {
        'email': email,
        'password': password,
      });
    } on DioException catch (error) {
      logger.e(error);
    } catch (error) {
      logger.e(error);
    }
  }

  Future<void> logout() async {
    // Call the logout API
  }

  Future<void> register(String email, String password) async {
    // Call the register API
  }
}
