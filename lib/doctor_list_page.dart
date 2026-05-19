import 'package:flutter/material.dart';
import 'token_booking_page.dart';

class DoctorListPage extends StatelessWidget {
  final String department;

  DoctorListPage({required this.department});

  final Map<String, List<Map<String, String>>> doctorsByDept = {
    'Cardiology': [
      {'name': 'Dr. John Doe', 'age': '45', 'specialization': 'Cardiology', 'experience': '15 years', 'degree': 'MD, Cardiology'},
      {'name': 'Dr. Alice Smith', 'age': '38', 'specialization': 'Cardiology', 'experience': '10 years', 'degree': 'MBBS, MD'},
    ],
    'Neurology': [
      {'name': 'Dr. Clara White', 'age': '50', 'specialization': 'Neurology', 'experience': '20 years', 'degree': 'MD, Neurology'},
      {'name': 'Dr. David Lee', 'age': '40', 'specialization': 'Neurology', 'experience': '12 years', 'degree': 'MBBS, DM'},
    ],
    'Pediatrics': [
      {'name': 'Dr. Emma Brown', 'age': '35', 'specialization': 'Pediatrics', 'experience': '8 years', 'degree': 'MBBS, MD'},
    ],
    'Orthopedics': [
      {'name': 'Dr. Michael Green', 'age': '48', 'specialization': 'Orthopedics', 'experience': '18 years', 'degree': 'MS, Orthopedics'},
    ],
    'Dermatology': [
      {'name': 'Dr. Sarah Black', 'age': '37', 'specialization': 'Dermatology', 'experience': '9 years', 'degree': 'MBBS, MD'},
    ],
    'ENT': [
      {'name': 'Dr. Robert Gray', 'age': '42', 'specialization': 'ENT', 'experience': '14 years', 'degree': 'MS, ENT'},
    ],
    'Ophthalmology': [
      {'name': 'Dr. Linda Blue', 'age': '39', 'specialization': 'Ophthalmology', 'experience': '11 years', 'degree': 'MS, Ophthalmology'},
    ],
    'Gynecology': [
      {'name': 'Dr. Karen Yellow', 'age': '44', 'specialization': 'Gynecology', 'experience': '16 years', 'degree': 'MBBS, MD'},
    ],
    'Radiology': [
      {'name': 'Dr. James Orange', 'age': '46', 'specialization': 'Radiology', 'experience': '17 years', 'degree': 'MD, Radiology'},
    ],
    'Oncology': [
      {'name': 'Dr. Patricia Purple', 'age': '41', 'specialization': 'Oncology', 'experience': '13 years', 'degree': 'MD, Oncology'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final deptDoctors = doctorsByDept[department] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text("$department Doctors"),
        backgroundColor: Colors.blue.shade700,
      ),
      body: deptDoctors.isEmpty
          ? Center(child: Text("No doctors available in $department"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: deptDoctors.length,
              itemBuilder: (context, index) {
                final doc = deptDoctors[index];
                return Card(
                  elevation: 6,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TokenBookingPage(doctor: doc),
                        ),
                      );
                    },
                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(Icons.person, color: Colors.blue.shade700),
                    ),
                    title: Text(doc['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text("Age: ${doc['age']}"),
                        Text("Specialization: ${doc['specialization']}"),
                        Text("Experience: ${doc['experience']}"),
                        Text("Degree: ${doc['degree']}"),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
