import 'package:flutter/material.dart';
import 'dashboard_page.dart';

class DoctorManagementPage extends StatelessWidget {
  const DoctorManagementPage({super.key});

  final List<String> doctors = const ["Dr. Smith", "Dr. Johnson", "Dr. Brown"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Doctor Management")),
      drawer: const AdminDrawer(currentPage: "doctors"),
      body: ListView.builder(
        itemCount: doctors.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.blue),
              title: Text(doctors[index]),
              subtitle: const Text("Available: 9 AM - 5 PM"),
              trailing: const Icon(Icons.edit, color: Colors.grey),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
