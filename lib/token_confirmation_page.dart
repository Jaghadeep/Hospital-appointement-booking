import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TokenConfirmationPage extends StatelessWidget {
  final String name;
  final String age;
  final String regNo;
  final String mobile;
  final DateTime bookedDate;
  final int tokenNumber;

  const TokenConfirmationPage({
    super.key,
    required this.name,
    required this.age,
    required this.regNo,
    required this.mobile,
    required this.bookedDate,
    required this.tokenNumber,
  });

  void _viewStatus(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        // Here you can fetch actual token status from Firestore
        // For now, using static demo data
        final upcomingTokens = [tokenNumber + 1, tokenNumber + 2];
        final servingToken = tokenNumber;

        return AlertDialog(
          title: const Text("Token Status"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Now Serving Token No: $servingToken",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green)),
              const SizedBox(height: 12),
              if (upcomingTokens.isNotEmpty)
                Column(
                  children: [
                    const Text("Upcoming Patients:"),
                    for (var t in upcomingTokens)
                      Text("Token No: $t - Please Wait",
                          style: const TextStyle(color: Colors.orange)),
                  ],
                ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Token Confirmation"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 126, 75, 189),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFa18cd1), Color(0xFFfbc2eb)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle,
                    color: Colors.green, size: 80),
                const SizedBox(height: 10),
                const Text(
                  "Booking Confirmed!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 20),

                // Token Info
                Text("Name: $name", style: const TextStyle(fontSize: 18)),
                Text("Age: $age", style: const TextStyle(fontSize: 18)),
                Text("Register No: $regNo", style: const TextStyle(fontSize: 18)),
                Text("Mobile: $mobile", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text(
                  "Date: ${DateFormat('dd MMM yyyy').format(bookedDate)}",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  "Token Number: $tokenNumber",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
                const SizedBox(height: 20),

                // QR Code
                QrImageView(
                  data:
                      "Name:$name, RegNo:$regNo, Date:${DateFormat('dd-MM-yyyy').format(bookedDate)}, Token:$tokenNumber",
                  version: QrVersions.auto,
                  size: 120.0,
                  gapless: false,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 15),

                // Estimated time
                Text(
                  "Estimated Waiting Time: ${tokenNumber * 5} minutes",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.deepPurple),
                ),
                const SizedBox(height: 20),

                // View Status Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _viewStatus(context),
                    icon: const Icon(Icons.visibility),
                    label: const Text(
                    "View Status",
                  style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white, 
                  ),
                 ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
