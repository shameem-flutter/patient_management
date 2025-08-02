import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:patient_management/models/login_response.dart';
import 'package:patient_management/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isloading = false;
  bool get isloading => _isloading;

  LoginResponse? _loginResponse;
  LoginResponse? get loginResponse => _loginResponse;

  Future<bool> login(String username, String password) async {
    _isloading = true;
    notifyListeners();

    try {
      final response = await _apiService.login(username, password);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["status"] == true) {
        _loginResponse = LoginResponse.fromJson(data);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", _loginResponse!.token);

        _isloading = false;
        notifyListeners();
        return true;
      } else {
        _isloading = false;
        notifyListeners();
        throw Exception(data["message"] ?? "Login failed");
      }
    } catch (e) {
      _isloading = false;
      notifyListeners();
      rethrow;
    }
  }
}
