// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:comfystay/components/CustomButton.dart';
import 'package:comfystay/components/CustomTextField.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Register the user with Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      User? user = userCredential.user;

      if (user != null) {
        String userId = user.uid;

        // Store user data in Firestore
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'id': userId,
          'name': _fullNameController.text.trim(),
          'email': _emailController.text.trim(),
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Store login state in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        // Show success message
        Get.snackbar(
          "Success",
          "Account created successfully!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to the home page
        Get.toNamed('/home');
      }
    } on FirebaseAuthException catch (e) {
      setState(() => _isLoading = false);

      // Handle Firebase errors
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already in use.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is invalid.';
          break;
        case 'weak-password':
          errorMessage = 'The password is too weak.';
          break;
        default:
          errorMessage = 'An unknown error occurred.';
      }

      Get.snackbar(
        "Registration Failed",
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/logo.png', width: 140, height: 70),
                const Row(
                  children: [
                    Text(
                      "Let's Do It ",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Quickly ",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(20, 133, 115, 1)),
                    ),
                  ],
                ),
                const Text(
                  "SIGN UP NOW",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                CustomTextField(
                  label: "Full Name",
                  icon: Icons.person,
                  hint: 'Adam Anderson',
                  controller: _fullNameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Full Name is required';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  label: "Email",
                  icon: Icons.email,
                  hint: 'adam@gmail.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  label: "Password",
                  icon: Icons.lock,
                  hint: 'Password',
                  isPassword: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  label: "Confirm Password",
                  icon: Icons.lock,
                  hint: 'Confirm Password',
                  isPassword: true,
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                GestureDetector(
                  onTap: _isLoading ? null : _register,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const CustomButton(
                            text: "Sign Up",
                          ),
                  ),
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                    ),
                    Text(
                      "OR",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Add Google sign-in logic here
                      },
                      child:
                          Image.asset('assets/images/google.png', height: 50),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Add Facebook sign-in logic here
                      },
                      child: const Icon(
                        Icons.facebook,
                        color: Colors.blue,
                        size: 50,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/login");
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
