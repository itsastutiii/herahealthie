import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final medicationsController = TextEditingController();
  final familyHistoryController = TextEditingController();

  String? _selectedBloodGroup;
  bool _obscurePassword = true;
  List<String> medications = [];
  List<Map<String, String>> familyHistory = [];

  // List of blood groups for the dropdown
  final List<String> bloodGroups = [
    'A+',
    'B+',
    'O+',
    'AB+',
    'A-',
    'B-',
    'O-',
    'AB-'
  ];

  // Future<void> signUp() async {
  //   try {
  //     // Firebase Authentication sign up
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim(),
  //     );

  //     // Save the user details to Firestore (excluding password)
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userCredential.user!.uid)
  //         .set({
  //       'name': nameController.text.trim(),
  //       'email': emailController.text.trim(),
  //       'age': int.tryParse(ageController.text.trim()) ?? 0,
  //       'height': double.tryParse(heightController.text.trim()) ?? 0.0,
  //       'weight': double.tryParse(weightController.text.trim()) ?? 0.0,
  //       'bloodGroup': _selectedBloodGroup,
  //       'medications': medications,
  //       'familyHistory': familyHistory,
  //     });

  //     // Navigate to the home screen after successful sign-up
  //     Navigator.pushReplacementNamed(context, '/home');
  //   } catch (e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('Sign-up failed: $e')));
  //   }
  // }
  Future<void> signUp() async {
    try {
      // Firebase Authentication sign-up
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Save user details to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'age': int.tryParse(ageController.text.trim()) ?? 0,
        'height': double.tryParse(heightController.text.trim()) ?? 0.0,
        'weight': double.tryParse(weightController.text.trim()) ?? 0.0,
        'bloodGroup': _selectedBloodGroup,
        'medications': medications, // List of medications
        'familyHistory': familyHistory, // List of family history records
      });

      // Navigate to home screen after successful sign-up
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      // Display error if sign-up fails
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Sign-up failed: $e')));
    }
  }

  // Method to add a medication to the list
  void _addMedication() {
    if (medicationsController.text.isNotEmpty) {
      setState(() {
        medications.add(medicationsController.text.trim());
        medicationsController.clear();
      });
    }
  }

  // Method to add a family history record
  void _addFamilyHistory() {
    if (familyHistoryController.text.isNotEmpty) {
      setState(() {
        familyHistory.add({
          'relation': familyHistoryController.text.trim(),
          'issue': 'No issue yet', // Default value for issue
        });
        familyHistoryController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Create an Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 32),
              // Name field
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Email field
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Password field
              TextField(
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Age field
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Age',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Height field
              TextField(
                controller: heightController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Height (in cm)',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Weight field
              TextField(
                controller: weightController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Weight (in kg)',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Blood group dropdown
              DropdownButtonFormField<String>(
                value: _selectedBloodGroup,
                onChanged: (newValue) {
                  setState(() {
                    _selectedBloodGroup = newValue;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Blood Group',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: bloodGroups.map((bloodGroup) {
                  return DropdownMenuItem<String>(
                    value: bloodGroup,
                    child: Text(bloodGroup),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              // Medications field (Add multiple)
              TextField(
                controller: medicationsController,
                decoration: InputDecoration(
                  labelText: 'Medications (optional)',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: _addMedication,
              ),
              const SizedBox(height: 20),
              // Family history field (Add multiple)
              TextField(
                controller: familyHistoryController,
                decoration: InputDecoration(
                  labelText: 'Family Medical History (optional)',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: _addFamilyHistory,
              ),
              const SizedBox(height: 30),
              // Sign-up button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    shadowColor: Colors.pinkAccent.shade100,
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
