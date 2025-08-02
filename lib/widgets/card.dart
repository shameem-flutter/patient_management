import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TreatmentCard extends StatelessWidget {
  final int index;
  final String patientName;
  final String packageName;
  final String date;
  final String therapist;
  final bool hasBooking;
  final VoidCallback? onTap;

  const TreatmentCard({
    required this.index,
    required this.patientName,
    required this.packageName,
    required this.date,
    required this.therapist,
    required this.hasBooking,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        '${index + 1}. $patientName',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Text(
                packageName,
                style: GoogleFonts.poppins(
                  color: const Color(0XFF006837),
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 8),

              Row(
                children: [
                  _buildDetailWithIcon(Icons.calendar_today, date),
                  const SizedBox(width: 16),
                  _buildDetailWithIcon(Icons.person_outline, therapist),
                ],
              ),
              const SizedBox(height: 16),

              const Divider(thickness: 1, color: Colors.black12),

              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 10, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "View Booking Details",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Color(0XFF006837),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailWithIcon(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.redAccent),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
