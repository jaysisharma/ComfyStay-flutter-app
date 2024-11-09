import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comfystay/components/CustomButton.dart';
import 'package:comfystay/components/CustomTextField.dart';
import 'package:comfystay/controllers/DataController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddContact extends StatelessWidget {
  AddContact({super.key}); // Removed 'const' because of controller

  // Controller for the contact input
  final TextEditingController contactController = TextEditingController();
  final DataController dataController = Get.find();

  Future<void> _submitData() async {
    print(
        'Type ${dataController.selectedPropertyType} conditions ${dataController.selectedConditions} contact :${dataController.contactNumber.value}');
    try {
      // Saving data to Firebase
      await FirebaseFirestore.instance.collection('property_details').add({
        'property_name': dataController.listingName.value,
        'property_description': dataController.listingDescription.value,
        'property_price': dataController.listingPrice.value,
        'type': dataController.selectedPropertyType.value,
        'conditions': dataController.selectedConditions,
        'whatsIncluded': dataController.selectedWhatsIncluded,
        'initialRequirements': dataController.selectedInitialRequirements,
        'contact': dataController.contactNumber.value,
        // Uncomment this when handling photos
        'photos': dataController.selectedPhotos.map((file) => file.path).toList(),
      });

      // Show a success message
      Get.snackbar(
        "Success",
        "Data has been saved successfully.",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Navigate to the home screen after submitting
      Get.offAllNamed("/home");
      dataController.clearData();
    } catch (e) {
      print("${e.toString()} Error");
      // If something goes wrong, show an error message
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
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
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              label: "Contact No",
              icon: Icons.call,
              hint: "7294792827",
              controller: contactController,
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                final contactNumber = contactController.text;

                if (contactNumber.isNotEmpty) {
                  // Save the contact number to the controller
                  dataController.setContactNumber(contactNumber);

                  // Submit the data to Firebase
                  _submitData();
                } else {
                  // Show an error if the contact field is empty
                  Get.snackbar(
                    "Error",
                    "Please enter a contact number.",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: CustomButton(text: "Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
