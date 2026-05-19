import 'package:flutter/material.dart';
import 'doctor_management_page.dart';
import 'queue_management_page.dart';
import 'patient_management_page.dart';
import 'reports_page.dart';
import 'settings_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Dashboard")),
      drawer: const AdminDrawer(currentPage: "dashboard"),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 600;
          return GridView.count(
            crossAxisCount: isWide ? 3 : 1,
            padding: const EdgeInsets.all(16),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _infoCard(Icons.people, "Total Patients", "120"),
              _infoCard(Icons.queue, "Active Queues", "15"),
              _infoCard(Icons.medical_services, "Doctors", "8"),
            ],
          );
        },
      ),
    );
  }

  Widget _infoCard(IconData icon, String title, String value) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.blue),
            const SizedBox(height: 15),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(title, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}


class AdminDrawer extends StatelessWidget {
  final String currentPage;
  const AdminDrawer({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue.shade700),
            child: const Align(
              alignment: Alignment.bottomLeft,
              child: Text("Admin Panel",
                  style: TextStyle(fontSize: 22, color: Colors.white)),
            ),
          ),
          _drawerItem(context, Icons.dashboard, "Dashboard", const DashboardPage(), "dashboard"),
          _drawerItem(context, Icons.medical_services, "Doctors", const DoctorManagementPage(), "doctors"),
          _drawerItem(context, Icons.queue, "Queue", const QueueManagementPage(), "queue"),
          _drawerItem(context, Icons.people, "Patients", const PatientManagementPage(), "patients"),
          _drawerItem(context, Icons.bar_chart, "Reports", const ReportsPage(), "reports"),
          _drawerItem(context, Icons.settings, "Settings", const SettingsPage(), "settings"),
        ],
      ),
    );
  }

  Widget _drawerItem(BuildContext ctx, IconData icon, String title, Widget page, String name) {
    return ListTile(
      leading: Icon(icon, color: currentPage == name ? Colors.blue : Colors.grey),
      title: Text(title),
      selected: currentPage == name,
      onTap: () {
        Navigator.pushReplacement(ctx, MaterialPageRoute(builder: (_) => page));
      },
    );
  }
}
