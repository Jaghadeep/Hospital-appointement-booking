import 'package:flutter/material.dart';
import 'doctor_list_page.dart';

class DepartmentDashboard extends StatelessWidget {
  final List<Map<String, dynamic>> departments = [
    {'name': 'Cardiology', 'icon': Icons.favorite, 'color': Colors.redAccent},
    {'name': 'Neurology', 'icon': Icons.psychology, 'color': Colors.purpleAccent},
    {'name': 'Pediatrics', 'icon': Icons.child_care, 'color': Colors.orangeAccent},
    {'name': 'Orthopedics', 'icon': Icons.accessibility_new, 'color': Colors.greenAccent},
    {'name': 'Dermatology', 'icon': Icons.healing, 'color': Colors.tealAccent},
    {'name': 'ENT', 'icon': Icons.hearing, 'color': Colors.blueAccent},
    {'name': 'Ophthalmology', 'icon': Icons.remove_red_eye, 'color': Colors.indigoAccent},
    {'name': 'Gynecology', 'icon': Icons.pregnant_woman, 'color': Colors.pinkAccent},
    {'name': 'Radiology', 'icon': Icons.radio, 'color': Colors.deepOrangeAccent},
    {'name': 'Oncology', 'icon': Icons.biotech, 'color': Colors.deepPurpleAccent},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Department Dashboard"),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: departments.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.05,
          ),
          itemBuilder: (context, index) {
            final dept = departments[index];
            return Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: Colors.grey.shade400,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  // Navigate to DoctorListPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorListPage(department: dept['name']),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        dept['color'].withOpacity(0.7),
                        dept['color'],
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(dept['icon'], size: 50, color: Colors.white),
                      const SizedBox(height: 12),
                      Text(
                        dept['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
