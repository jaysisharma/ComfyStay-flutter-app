import 'package:comfystay/components/CustomButton.dart';
import 'package:comfystay/components/CustomTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isObscureOld = true;
  bool _isObscureNew = true;
  bool _isObscureConfirm = true;

  String? _errorMessage;
  bool _isLoading = false; // New variable to track loading state

  // Function to update the password
  Future<void> _changePassword() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      final currentUser = _auth.currentUser;

      if (currentUser == null) {
        setState(() {
          _errorMessage = "User not authenticated.";
          _isLoading = false; // Stop loading
        });
        return;
      }

      // Ensure the passwords match
      if (_newPasswordController.text != _confirmPasswordController.text) {
        setState(() {
          _errorMessage = "New password and confirm password do not match.";
          _isLoading = false; // Stop loading
        });
        return;
      }

      // Re-authenticate the user with their old password
      AuthCredential credential = EmailAuthProvider.credential(
        email: currentUser.email!,
        password: _oldPasswordController.text,
      );

      await currentUser.reauthenticateWithCredential(credential);

      // Update the password
      await currentUser.updatePassword(_newPasswordController.text);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password changed successfully!")),
      );

      // Optionally, clear the fields after successful password change
      _oldPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();

      setState(() {
        _isLoading = false; // Stop loading
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
        _isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          "Change Password",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Old Password Text Field
              CustomTextField(
                controller: _oldPasswordController,
                label: "Old Password",
                icon: Icons.lock,
                hint: "Enter your old password",
              ),
              SizedBox(height: 10),
        
              // New Password Text Field
              CustomTextField(
                controller: _newPasswordController,
                label: "New Password",
                icon: Icons.lock,
                hint: "Enter a new password",
              ),
              SizedBox(height: 10),
        
              // Confirm Password Text Field
              CustomTextField(
                controller: _confirmPasswordController,
                label: "Confirm Password",
                icon: Icons.lock,
                hint: "Re-enter new password",
              ),
              SizedBox(height: 10),
        
              // Error message if any
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
        
              // Progress indicator if loading
              if (_isLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),
              // Submit Button
              if (!_isLoading) // Show button only if not loading
                GestureDetector(
                  onTap: _changePassword,
                  child: CustomButton(
                    text: "Submit",
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
