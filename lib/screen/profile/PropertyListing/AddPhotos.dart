import 'dart:io';
import 'package:comfystay/controllers/DataController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddPhotosPage extends StatefulWidget {
  @override
  _AddPhotosPageState createState() => _AddPhotosPageState();
}

class _AddPhotosPageState extends State<AddPhotosPage> {
  final List<File> _photos = []; // Store photos selected by user
  final DataController dataController = Get.find();
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false; // Loading state

  // Method to pick an image from the gallery
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _photos.add(File(image.path));
      });
    }
  }

  // Method to handle "Next" button click
  Future<void> _handleNext() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    try {
      dataController.addPhotos(_photos); // Store photos in controller

      // Simulating a delay for upload (e.g., cloud upload)
      await Future.delayed(Duration(seconds: 2)); // Replace with actual upload

      Get.toNamed('/addContact');
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        isLoading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Photos'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Photo grid to display selected images
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 photos per row
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                ),
                itemCount: _photos.length + 1, // Extra count for "Add" button
                itemBuilder: (context, index) {
                  if (index < _photos.length) {
                    // Display each picked photo with option to remove
                    return GestureDetector(
                      onLongPress: () {
                        setState(() {
                          _photos.removeAt(index); // Remove photo from list
                        });
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.file(
                              _photos[index],
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _photos.removeAt(index); // Remove photo from list
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    // "Add" button for picking new images
                    return GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.shade300,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            size: 40.0,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20.0),
            // "Next" button to navigate to AddContact page
            GestureDetector(
              onTap: isLoading ? null : _handleNext, // Disable if loading
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.teal,
                ),
                child: Center(
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white) // Show loading
                      : const Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
