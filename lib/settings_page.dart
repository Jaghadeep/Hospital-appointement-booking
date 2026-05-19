import 'package:flutter/material.dart';
import 'dashboard_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      drawer: const AdminDrawer(currentPage: "settings"),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.red),
            title: const Text("Change Password"),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.blue),
            title: const Text("About App"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
