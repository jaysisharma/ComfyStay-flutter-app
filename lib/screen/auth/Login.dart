import 'package:comfystay/components/CustomButton.dart';
import 'package:comfystay/components/CustomTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/logo.png', width: 140,height: 140,),
              const Row(
                children: [
                  Text(
                    "You're ",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Missed ",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(20, 133, 115, 1)),
                  ),
                ],
              ),
              const Text(
                "SIGN IN NOW",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 40,
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
        
              GestureDetector(
                onTap: (){
                  Get.toNamed('/home');
                },
                child: const CustomButton(
                  text: "Sign In",
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
               Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/images/google.png'),
                  Icon(
                    Icons.facebook,
                    color: Colors.blue,
                  )
                ],
              ),
              SizedBox(height: 40,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed("/register");
                    },
                    child: Text(
                      "Sign Up",
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
    );
  }
}
