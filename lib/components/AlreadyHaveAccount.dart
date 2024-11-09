import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account? ", style: TextStyle(fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: () {
            Get.toNamed("/login");
          },
          child: Text(
            "Sign In",
            style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
