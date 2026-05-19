import 'package:flutter/material.dart';
import 'dashboard_page.dart';

class QueueManagementPage extends StatelessWidget {
  const QueueManagementPage({super.key});

  final List<Map<String, String>> queue = const [
    {"name": "Deva", "status": "Waiting"},
    {"name": "Simon", "status": "In Progress"},
    {"name": "Dayal", "status": "Completed"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Queue Management")),
      drawer: const AdminDrawer(currentPage: "queue"),
      body: ListView.builder(
        itemCount: queue.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.people, color: Colors.blue),
              title: Text(queue[index]["name"]!),
              subtitle: Text("Status: ${queue[index]["status"]}"),
              trailing: ElevatedButton(
                onPressed: () {},
                child: const Text("Update"),
              ),
            ),
          );
        },
      ),
    );
  }
}
