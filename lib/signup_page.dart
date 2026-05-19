import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'hospital_list_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _signUp() async {
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      // Firebase Auth signup
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate to hospital list
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HospitalListPage()),
      );
    } catch (e) {
      print('Signup error: $e');
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Signup Failed'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF0D47A1), // Deep blue header
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1565C0), Color(0xFF42A5F5)], // Blue gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 10,
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: isMobile ? double.infinity : 400, // responsive width
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                child: Column(
                  children: [
                    const Text(
                      "Create Your Account",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: const TextStyle(color: Colors.black87),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        prefixIcon: const Icon(Icons.email_outlined, color: Colors.blueAccent),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.black87),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        prefixIcon: const Icon(Icons.lock_outline, color: Colors.blueAccent),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _signUp,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: const Color(0xFF42A5F5), // Brighter button color
                          foregroundColor: Colors.white, // White text for contrast
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
