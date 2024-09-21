import 'package:comfystay/components/CustomTextField.dart';
import 'package:flutter/material.dart';

class AddContact extends StatelessWidget {
  const AddContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomTextField(label: "Contact No", icon: Icons.call, hint: "7294792827")
        ],
      ),
    );
  }
}