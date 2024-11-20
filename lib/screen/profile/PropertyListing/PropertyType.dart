import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/CustomButton.dart';
import '../../../components/ListingField.dart';
import '../../../controllers/DataController.dart';

class PropertyType extends StatelessWidget {
  const PropertyType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title:
            Text('Choose Property Type', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0, // Remove default AppBar shadow
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _setPropertyTypeAndNavigate("PG");
              },
              child: _buildType("PG", "pg.png"),
            ),
            GestureDetector(
              onTap: () {
                _setPropertyTypeAndNavigate("Room");
              },
              child: _buildType("Room", "room.png"),
            ),
            GestureDetector(
              onTap: () {
                _setPropertyTypeAndNavigate("Villa");
              },
              child: _buildType("Villa", "villa.png"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildType(String type, String image) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          children: [
            Image.asset(
              "assets/images/$image",
              height: 50,
            ),
            SizedBox(width: 20), // Add space between image and text
            Text(
              type,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setPropertyTypeAndNavigate(String type) {
    final DataController dataController = Get.find();
    dataController.setPropertyType(
        type); // Save the selected property type in the controller
    Get.toNamed("/listing", arguments: type); // Pass the type as an argument
  }
}

class ListingPage extends StatelessWidget {
  const ListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String propertyType = Get.arguments ??
        "PG"; // Get the property type passed from PropertyType screen

    // Controllers to capture the input text
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController locationController =
        TextEditingController(); // New location controller

    // Validation function
    void validateAndNavigate() {
      if (nameController.text.isEmpty ||
          descriptionController.text.isEmpty ||
          priceController.text.isEmpty ||
          locationController.text.isEmpty) {
        Get.snackbar('Error', 'Please fill in all fields.');
      } else if (int.tryParse(priceController.text) == null) {
        Get.snackbar('Error', 'Price must be a valid number.');
      } else {
        final DataController dataController = Get.find();
        dataController.setListingData(
          nameController.text,
          descriptionController.text,
          priceController.text,
        );
        dataController.setListingLocation(locationController.text);

        Get.toNamed("/conditions");
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: Text("$propertyType Listing"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListingTextField(
                text: "$propertyType Name",
                controller: nameController, // Pass controller here
              ),
              ListingTextField(
                text: "$propertyType Description",
                controller: descriptionController, // Pass controller here
              ),
              ListingTextField(
                text: "$propertyType Price/Month",
                controller: priceController, // Pass controller here
              ),
              ListingTextField(
                text: "$propertyType Location",
                controller: locationController, // New location text field
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: GestureDetector(
                  onTap:
                      validateAndNavigate, // Call the validation function on tap
                  child: CustomButton(text: "Next"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
