import 'package:patient_management/models/branch.dart';

class BranchListResponse {
  final bool status;
  final String message;
  final List<Branch> branches;

  BranchListResponse({
    required this.status,
    required this.message,
    required this.branches,
  });

  factory BranchListResponse.fromJson(Map<String, dynamic> json) {
    return BranchListResponse(
      status: json['status'],
      message: json['message'],
      branches: List<Branch>.from(
        json['branches'].map((x) => Branch.fromJson(x)),
      ),
    );
  }
}
