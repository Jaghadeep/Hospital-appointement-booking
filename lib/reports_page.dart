import 'package:flutter/material.dart';
import 'dashboard_page.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reports & Analytics")),
      drawer: const AdminDrawer(currentPage: "reports"),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bar_chart, size: 80, color: Colors.blue),
            SizedBox(height: 20),
            Text("Reports Coming Soon",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
