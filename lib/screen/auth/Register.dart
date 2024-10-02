import 'package:comfystay/components/CustomButton.dart';
import 'package:comfystay/components/CustomTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'images/logo.png',
              width: 140,
              height: 140,
            ),
            const Row(
              children: [
                Text(
                  "Let's Do It ",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
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
            const SizedBox(
              height: 40,
            ),
            const CustomTextField(
              label: "Full Name",
              icon: Icons.person,
              hint: 'Adam Anderson',
            ),
            const CustomTextField(
              label: "Email",
              icon: Icons.email,
              hint: 'adam@gmail.com',
            ),
            const CustomTextField(
              label: "Passsword",
              icon: Icons.key,
              hint: 'Password',
            ),
            const CustomTextField(
              label: "Confirm Password",
              icon: Icons.key,
              hint: 'Password',
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed("/profile");
              },
              child: const CustomButton(
                text: "Sign Up",
              ),
            ),
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey, // Color of the line
                    thickness: 1, // Thickness of the line
                    indent: 20, // Indent from the start
                    endIndent: 20,
                  ),
                ),
                Text(
                  "OR",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.grey, // Color of the line
                    thickness: 1, // Thickness of the line
                    indent: 20, // Indent from the start
                    endIndent: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.facebook,
                  color: Colors.blue,
                ),
                Icon(
                  Icons.facebook,
                  color: Colors.blue,
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
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
    );
  }
}
