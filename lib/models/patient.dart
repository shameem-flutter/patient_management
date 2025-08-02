class PatientDetail {
  final int id;
  final String? male;
  final String? female;
  final int patientId;
  final int? treatment;
  final String? treatmentName;

  PatientDetail({
    required this.id,
    this.male,
    this.female,
    required this.patientId,
    this.treatment,
    this.treatmentName,
  });

  factory PatientDetail.fromJson(Map<String, dynamic> json) {
    return PatientDetail(
      id: json['id'],
      male: json['male'],
      female: json['female'],
      patientId: json['patient'],
      treatment: json['treatment'],
      treatmentName: json['treatment_name'],
    );
  }
}

class Patient {
  final int id;
  final String name;
  final String phone;
  final String address;
  final String user;
  final String payment;
  final double? totalAmount;
  final double? discountAmount;
  final double? advanceAmount;
  final double? balanceAmount;
  final String dateTime;
  final List<PatientDetail> patientdetailsSet;

  Patient({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.user,
    required this.payment,
    this.totalAmount,
    this.discountAmount,
    this.advanceAmount,
    this.balanceAmount,
    required this.dateTime,
    required this.patientdetailsSet,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      user: json['user'] ?? '',
      payment: json['payment'] ?? '',
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      discountAmount: (json['discount_amount'] ?? 0).toDouble(),
      advanceAmount: (json['advance_amount'] ?? 0).toDouble(),
      balanceAmount: (json['balance_amount'] ?? 0).toDouble(),
      dateTime: json['date_nd_time'] ?? '',
      patientdetailsSet: (json['patientdetails_set'] as List<dynamic>)
          .map((detail) => PatientDetail.fromJson(detail))
          .toList(),
    );
  }
}
