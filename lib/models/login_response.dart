import 'package:patient_management/models/user_details.dart';

class LoginResponse {
  final bool status;
  final String message;
  final String token;
  final bool isSuperuser;
  final UserDetails userDetails;

  LoginResponse({
    required this.status,
    required this.message,
    required this.token,
    required this.isSuperuser,
    required this.userDetails,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      token: json['token'],
      isSuperuser: json['is_superuser'],
      userDetails: UserDetails.fromJson(json['userDetails']),
    );
  }
}
