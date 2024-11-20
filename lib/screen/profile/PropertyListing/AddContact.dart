import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comfystay/components/CustomButton.dart';
import 'package:comfystay/components/CustomTextField.dart';
import 'package:comfystay/controllers/DataController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddContact extends StatefulWidget {
  AddContact({super.key});

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final TextEditingController contactController = TextEditingController();
  final DataController dataController = Get.find();
  bool isLoading = false; // Track loading state

  Future<void> _submitData() async {
    setState(() {
      isLoading = true; // Start loading
    });

    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      // Saving data to Firebase
      if (currentUser != null) {
        String userId = currentUser.uid; // The current user ID

        // Generate a unique property ID
        String propertyId = FirebaseFirestore.instance.collection('property_details').doc().id;

        // Upload images to Cloudinary if needed
        for (var photo in dataController.selectedPhotos) {
          final imageUrl = await dataController.uploadImageToCloudinary(photo);
          if (imageUrl != null) {
            dataController.cloudinaryImageUrls.add(imageUrl);
          }
        }

        // Add property details to Firestore
        await FirebaseFirestore.instance.collection('property_details').doc(propertyId).set({
          'property_id': propertyId, // Add the propertyId to the document
          'user_id': userId,
          'property_name': dataController.listingName.value,
          'property_description': dataController.listingDescription.value,
          'property_price': dataController.listingPrice.value,
          'type': dataController.selectedPropertyType.value,
          'conditions': dataController.selectedConditions,
          'whatsIncluded': dataController.selectedWhatsIncluded,
          'initialRequirements': dataController.selectedInitialRequirements,
          'contact': dataController.contactNumber.value,
          'location': dataController.listingLocation.value,
          'photos': dataController.cloudinaryImageUrls, // Store Cloudinary URLs in Firestore
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
      } else {
        print('Error: User not authenticated');
      }
    } catch (e) {
      print("${e.toString()} Error");
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
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
            isLoading
                ? CircularProgressIndicator() // Show progress indicator if loading
                : GestureDetector(
                    onTap: () {
                      final contactNumber = contactController.text;

                      if (contactNumber.isNotEmpty) {
                        // Save the contact number to the controller
                        dataController.setContactNumber(contactNumber);

                        // Submit the data to Firebase
                        _submitData();
                      } else {
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
