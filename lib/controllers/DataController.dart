import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class DataController extends GetxController {
  // Variables to store listing data
  var selectedPropertyType = ''.obs;
  var listingName = ''.obs;
  var listingDescription = ''.obs;
  var listingPrice = 0.obs;
  var listingLocation = ''.obs;

  // Media and conditions
  var selectedConditions = <String>[].obs;
  var selectedInitialRequirements = <String>[].obs;
  var selectedWhatsIncluded = <String>[].obs;
  var contactNumber = ''.obs;
  var selectedPhotos = <File>[].obs;
  var cloudinaryImageUrls = <String>[].obs;

  // Set methods
  void setPropertyType(String type) => selectedPropertyType.value = type;
  void setListingData(String name, String description, String price) {
    listingName.value = name;
    listingDescription.value = description;
    listingPrice.value = int.tryParse(price) ?? 0;
  }

  void setListingLocation(String location) => listingLocation.value = location;
  void setContactNumber(String contact) => contactNumber.value = contact;
  void addCondition(String condition) => selectedConditions.add(condition);
  void addInitialRequirement(String requirement) =>
      selectedInitialRequirements.add(requirement);
  void addWhatsIncluded(String included) => selectedWhatsIncluded.add(included);
  void addPhotos(List<File> photos) => selectedPhotos.addAll(photos);

  // Upload a single image to Cloudinary
  Future<String?> uploadImageToCloudinary(File imageFile) async {
    final cloudName = 'drgriybgm';
    final uploadPreset = 'listing';
    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseData);
      return jsonResponse['secure_url'];
    } else {
      print('Failed to upload image: ${response.statusCode}');
      return null;
    }
  }

  // Upload all selected photos to Cloudinary, then save the data in Firestore
  Future<void> uploadPhotosToCloudinaryAndSaveToFirestore(String userId) async {
    for (var photo in selectedPhotos) {
      final imageUrl = await uploadImageToCloudinary(photo);
      if (imageUrl != null) {
        cloudinaryImageUrls.add(imageUrl);
      }
    }

    await FirebaseFirestore.instance.collection('property_details').add({
      'user_id': userId,
      'property_name': listingName.value,
      'property_description': listingDescription.value,
      'property_price': listingPrice.value,
      'type': selectedPropertyType.value,
      'conditions': selectedConditions,
      'whatsIncluded': selectedWhatsIncluded,
      'initialRequirements': selectedInitialRequirements,
      'contact': contactNumber.value,
      'location': listingLocation.value,
      'photos': cloudinaryImageUrls, // Store Cloudinary URLs in Firestore
    });
  }

  // Clear all data after submission
  void clearData() {
    selectedPropertyType.value = '';
    listingName.value = '';
    listingDescription.value = '';
    listingPrice.value = 0;
    listingLocation.value = '';
    selectedConditions.clear();
    selectedInitialRequirements.clear();
    selectedWhatsIncluded.clear();
    contactNumber.value = '';
    selectedPhotos.clear();
    cloudinaryImageUrls.clear();
  }
}
