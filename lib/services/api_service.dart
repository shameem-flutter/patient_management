import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = "https://flutter-amr.noviindus.in/api";
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Future<http.Response> login(String username, String password) async {
    final url = Uri.parse("$baseUrl/Login");
    return await http.post(
      url,
      body: {"username": username, "password": password},
    );
  }

  Future<http.Response> getPatientList() async {
    final token = await getToken();
    final url = Uri.parse("$baseUrl/PatientList");
    return await http.get(url, headers: {"Authorization": "Bearer $token"});
  }

  Future<http.Response> getBranches() async {
    final token = await getToken();
    final url = Uri.parse("$baseUrl/BranchList");
    return await http.get(url, headers: {"Authorization": "Bearer $token"});
  }

  Future<http.Response> getTreatmentList() async {
    final token = await getToken();
    final url = Uri.parse("$baseUrl/TreatmentList");
    return await http.get(url, headers: {"Authorisation": "Bearer $token"});
  }

  Future<http.Response> registerPatient(Map<String, dynamic> data) async {
    final token = await getToken();
    final url = Uri.parse("$baseUrl/PatientUpdate");
    return await http.post(
      url,
      headers: {"Authorization": "Bearer $token"},
      body: token,
    );
  }
}
