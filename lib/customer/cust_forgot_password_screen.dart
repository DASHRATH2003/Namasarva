// bus_booking_application

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'cust_password_update_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _pet1Controller = TextEditingController();
  final _pet2Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _checkHints() async {
    if (_formKey.currentState!.validate()) {
      try {
        final pet1 = _pet1Controller.text.trim();
        final pet2 = _pet2Controller.text.trim();

        // Assuming the user is already logged in
        User? currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser != null) {
          // Fetch the user's document from Firestore
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('customers')
              .doc(currentUser.uid)
              .get();

          if (userDoc.exists) {
            // Get the stored pet1 and pet2 from the document
            String? storedPet1 = userDoc['pet1'] as String?;
            String? storedPet2 = userDoc['pet2'] as String?;

            if (storedPet1 == null || storedPet2 == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Security hints not set in your account.'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            // Check if either of the hints match
            if (pet1 == storedPet1 || pet2 == storedPet2) {
              // Navigate to the password update page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UpdatePasswordScreen()),
              );
            } else {
              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pet names do not match. Please try again.'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('User data not found.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User is not logged in.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[300],
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Pet1 TextField
                  TextFormField(
                    controller: _pet1Controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter Pet 1 Name (Password Recovery)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Pet 1 Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Pet2 TextField
                  TextFormField(
                    controller: _pet2Controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter Pet 2 Name (Password Recovery)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Pet 2 Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Continue Button
                  ElevatedButton(
                    onPressed: _checkHints,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[100],
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text('Continue', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pet1Controller.dispose();
    _pet2Controller.dispose();
    super.dispose();
  }
}
