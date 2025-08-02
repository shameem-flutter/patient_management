import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class HomeProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _data = '';
  String get data => _data;

  Future<void> loadHomeData() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return;

    try {
      final response = await _apiService.fetchHomeData(token);
      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _data = json.toString();
      } else {
        _data = "Failed to fetch";
      }
    } catch (e) {
      _data = "Error: $e";
    }

    _isLoading = false;
    notifyListeners();
  }
}
