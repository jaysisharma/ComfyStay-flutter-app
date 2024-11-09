import 'dart:io';
import 'package:get/get.dart';

class DataController extends GetxController {
  // Variables for property and listing data
  var selectedPropertyType = ''.obs;
  var listingName = ''.obs;
  var listingDescription = ''.obs;
  var listingPrice = ''.obs;

  // Variables for conditions and media
  var selectedConditions = <String>[].obs;
  var selectedInitialRequirements = <String>[].obs;  // New variable for Initial Requirements
  var selectedWhatsIncluded = <String>[].obs;  // New variable for What's Included
  var contactNumber = ''.obs;
  var selectedPhotos = <File>[].obs;

  // Set property type
  void setPropertyType(String type) {
    selectedPropertyType.value = type;
  }

  // Store the listing data (name, description, and price)
  void setListingData(String name, String description, String price) {
    listingName.value = name;
    listingDescription.value = description;
    listingPrice.value = price;
  }

  // Set the contact number
  void setContactNumber(String contact) {
    contactNumber.value = contact;
  }
  
  // Add a selected condition to the list
  void addCondition(String condition) {
    selectedConditions.add(condition);
  }

  // Add selected initial requirements
  void addInitialRequirement(String requirement) {
    selectedInitialRequirements.add(requirement);
  }

  // Add selected whats included
  void addWhatsIncluded(String included) {
    selectedWhatsIncluded.add(included);
  }

  // Add selected photos
  void addPhotos(List<File> photos) {
    selectedPhotos.addAll(photos);
  }

  // Method to clear all data in the controller
  void clearData() {
    selectedPropertyType.value = '';
    listingName.value = '';
    listingDescription.value = '';
    listingPrice.value = '';
    selectedConditions.clear();
    selectedInitialRequirements.clear();  // Clear initial requirements
    selectedWhatsIncluded.clear();  // Clear what's included
    contactNumber.value = '';
    selectedPhotos.clear();
  }
}
