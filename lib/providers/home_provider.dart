import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:patient_management/models/patient.dart';
import 'package:patient_management/services/api_service.dart';

class HomeProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Patient> _patients = [];
  List<Patient> _filteredPatients = [];

  List<Patient> get patients => _patients;
  List<Patient> get filteredPatients => _filteredPatients;

  Future<void> loadPatientList() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.getPatientList();
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> patientList = data['patient'];
        _patients = patientList.map((e) => Patient.fromJson(e)).toList();
        _filteredPatients = List.from(_patients);
      } else {
        _patients = [];
        _filteredPatients = [];
      }
    } catch (e) {
      _patients = [];
      _filteredPatients = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void filterPatients(String query) {
    if (query.isEmpty) {
      _filteredPatients = List.from(_patients);
    } else {
      _filteredPatients = _patients.where((patient) {
        return patient.name.toLowerCase().contains(query.toLowerCase()) ||
            patient.user.toLowerCase().contains(query.toLowerCase()) ||
            (patient.patientdetailsSet.isNotEmpty &&
                patient.patientdetailsSet.any(
                  (detail) =>
                      detail.treatmentName?.toLowerCase().contains(
                        query.toLowerCase(),
                      ) ??
                      false,
                ));
      }).toList();
    }
    notifyListeners();
  }

  void sortPatients(String sortBy) {
    switch (sortBy) {
      case 'Date':
        _filteredPatients.sort((a, b) => b.dateTime.compareTo(a.dateTime));
        break;
      case 'Name':
        _filteredPatients.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Therapist':
        _filteredPatients.sort((a, b) => a.user.compareTo(b.user));
        break;
    }
    notifyListeners();
  }
}
