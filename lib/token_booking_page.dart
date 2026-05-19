import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'token_confirmation_page.dart';

class TokenBookingPage extends StatefulWidget {
  final Map<String, String>? doctor; // <-- Add this parameter

  const TokenBookingPage({super.key, this.doctor}); // <-- Accept doctor

  @override
  _TokenBookingPageState createState() => _TokenBookingPageState();
}

class _TokenBookingPageState extends State<TokenBookingPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _regNoController = TextEditingController();
  final _mobileController = TextEditingController();

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  static int _tokenCounter = 0;
  int _currentToken = 0;

  Future<void> _bookToken() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _tokenCounter++;
        _currentToken = _tokenCounter;
      });

      try {
        await FirebaseFirestore.instance.collection("tokens").add({
          "name": _nameController.text,
          "age": _ageController.text,
          "regNo": _regNoController.text,
          "mobile": _mobileController.text,
          "bookedDate": _selectedDay,
          "doctor": widget.doctor != null ? widget.doctor!['name'] : null,
          "tokenNumber": _currentToken,
          "createdAt": Timestamp.now(),
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TokenConfirmationPage(
              name: _nameController.text,
              age: _ageController.text,
              regNo: _regNoController.text,
              mobile: _mobileController.text,
              bookedDate: _selectedDay,
              tokenNumber: _currentToken,
            ),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error booking token: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F9),
      appBar: AppBar(
        title: Text(
          widget.doctor != null
              ? "Book Appointment with ${widget.doctor!['name']}"
              : "Book Appointment",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 6,
        shadowColor: Colors.deepPurpleAccent.withOpacity(0.5),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Calendar Section
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 5,
              shadowColor: Colors.deepPurple.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "Select Appointment Date",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TableCalendar(
                      focusedDay: _focusedDay,
                      firstDay: DateTime.now(),
                      lastDay: DateTime.now().add(const Duration(days: 365)),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                      headerStyle: const HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                        titleTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.deepPurple,
                        ),
                        leftChevronIcon: Icon(Icons.chevron_left,
                            color: Colors.deepPurple),
                        rightChevronIcon: Icon(Icons.chevron_right,
                            color: Colors.deepPurple),
                      ),
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Form Section
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 5,
              shadowColor: Colors.deepPurple.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          prefixIcon: const Icon(Icons.person_outline,
                              color: Colors.deepPurple),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Enter patient name";
                          }
                          if (value.length < 3) {
                            return "Name must be at least 3 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Age",
                          prefixIcon: const Icon(Icons.cake_outlined,
                              color: Colors.deepPurple),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter age";
                          }
                          final age = int.tryParse(value);
                          if (age == null || age <= 0 || age > 120) {
                            return "Enter valid age (1–120)";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _regNoController,
                        decoration: InputDecoration(
                          labelText: "Register Number",
                          prefixIcon: const Icon(Icons.badge_outlined,
                              color: Colors.deepPurple),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter register number";
                          }
                          if (value.length < 4) {
                            return "Register number must be at least 4 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _mobileController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Mobile Number",
                          prefixIcon: const Icon(Icons.phone_android,
                              color: Colors.deepPurple),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter mobile number";
                          }
                          final regex = RegExp(r'^[0-9]{10}$');
                          if (!regex.hasMatch(value)) {
                            return "Enter valid 10-digit mobile number";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _bookToken,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 6,
                          ),
                          icon: const Icon(Icons.event_available,
                              color: Colors.white),
                          label: const Text(
                            "Book Token",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ), 
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
