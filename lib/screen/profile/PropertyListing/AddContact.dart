import 'package:comfystay/components/CustomButton.dart';
import 'package:comfystay/components/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddContact extends StatelessWidget {
  const AddContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Photos'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            CustomTextField(
               // label: "Contact No", icon: Icons.call, hint: "7294792827"),
                label: "Contact No", icon: Icons.call, hint: "7294792827"),
            GestureDetector(
                onTap: () {
                  Get.offAllNamed("/home");
                },
                child: CustomButton(text: "Submit"))
          ],
        ),
      ),
    );
  }
}
