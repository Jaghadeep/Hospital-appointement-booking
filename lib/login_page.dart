import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'hospital_list_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() async {
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      // Firebase Auth login
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HospitalListPage()),
      );
    } catch (e) {
      print('Login error: $e');
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Login Failed"),
          content: const Text("Invalid email or password."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF145DA0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              color: Colors.white.withOpacity(0.95),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              shadowColor: Colors.black45,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.lock_outline, size: 70, color: Color(0xFF145DA0)),
                    const SizedBox(height: 12),
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF145DA0),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(Icons.email, color: Color(0xFF145DA0)),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(Icons.lock, color: Color(0xFF145DA0)),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: const Color(0xFF007BFF), // Bright Blue
                          foregroundColor: Colors.white, // White text
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 4,
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ).copyWith(
                          overlayColor: MaterialStateProperty.all(
                            const Color(0xFF0056b3).withOpacity(0.2), // Hover/pressed effect
                          ),
                        ),
                        child: const Text("Login"),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Color(0xFF145DA0)),
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
