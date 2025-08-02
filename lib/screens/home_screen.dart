import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient_management/providers/home_provider.dart';
import 'package:patient_management/widgets/card.dart';
import 'package:patient_management/widgets/textbutton.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchField = TextEditingController();
  String selectedValue = 'Date';
  final List<String> _sortOptions = ['Date', 'Name', 'Therapist'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).loadPatientList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: searchField,
                    decoration: InputDecoration(
                      hintText: 'Search bookings',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      provider.filterPatients(value);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextButton(
                    text: "Search",
                    onPressed: () {
                      provider.filterPatients(searchField.text);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sort by :',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedValue,
                        borderRadius: BorderRadius.circular(12),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                          color: Colors.green,
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        items: _sortOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                          });
                          provider.sortPatients(newValue!);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<HomeProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (provider.filteredPatients.isEmpty) {
                    return Center(
                      child: Text(
                        'No treatments found',
                        style: GoogleFonts.poppins(),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: provider.filteredPatients.length,
                    itemBuilder: (context, index) {
                      final patient = provider.filteredPatients[index];
                      final treatment = patient.patientdetailsSet.isNotEmpty
                          ? patient.patientdetailsSet.first.treatmentName
                          : 'No Treatment';

                      return TreatmentCard(
                        index: index + 1,
                        patientName: patient.name,
                        packageName: treatment ?? 'No Treatment',
                        date: _formatDate(patient.dateTime),
                        therapist: patient.user,
                        hasBooking: patient.payment.isNotEmpty,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateTime) {
    try {
      final date = DateTime.parse(dateTime);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateTime;
    }
  }
}
