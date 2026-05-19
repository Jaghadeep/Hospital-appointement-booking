import 'package:flutter/material.dart';
import 'dashboard_page.dart';

class PatientManagementPage extends StatelessWidget {
  const PatientManagementPage({super.key});

  final List<String> patients = const ["Deva", "Simon", "Dayal"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Patient Management")),
      drawer: const AdminDrawer(currentPage: "patients"),
      body: ListView.builder(
        itemCount: patients.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.green),
              title: Text(patients[index]),
              subtitle: const Text("Last Visit: 2025-08-20"),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          );
        },
      ),
    );
  }
}
