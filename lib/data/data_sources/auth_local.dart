import 'package:flutter_kasir_apps_frontend/data/model/respons/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocal {
  Future<void> saveAuthData(AuthResponseModel authResponseModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_data', authResponseModel.toJson() as String);
  }

  Future<void> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_data');
  }

  Future<AuthResponseModel?> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('auth_data');
    return AuthResponseModel.fromJson(authData as Map<String, dynamic>);
  }
}
