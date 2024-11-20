import 'dart:math'; // Import to use Random for shuffling

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comfystay/components/PropertyCard.dart';
import 'package:comfystay/models/resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:comfystay/components/PropertyCard2.dart';
import 'package:comfystay/screen/dashboard/LoadingPropertyCard.dart';
import 'package:shimmer/shimmer.dart'; // Import shimmer package

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isLoading = true; // Initial loading state
  List<Property> featuredProperties = []; // To store fetched properties
  List<Property> recommendedProperties =
      []; // To store shuffled recommended properties
  List<Property> displayedProperties =
      []; // To store filtered properties for search
  TextEditingController searchController =
      TextEditingController(); // Controller for the search field

  @override
  void initState() {
    super.initState();
    // Fetch featured properties from Firestore
    fetchFeaturedProperties();

    // Listen to search changes
    searchController.addListener(() {
      filterProperties(searchController.text);
    });
  }

  // Fetch featured properties from Firestore
  Future<void> fetchFeaturedProperties() async {
    try {
      // Fetch 6 featured properties from Firestore's 'property_details' collection
      QuerySnapshot featuredSnapshot = await FirebaseFirestore.instance
          .collection('property_details')
          .limit(6) // Fetch only the first 6 properties for featured section
          .get();

      // Fetch all properties for the recommended section
      QuerySnapshot recommendedSnapshot = await FirebaseFirestore.instance
          .collection('property_details')
          .get(); // Fetch all properties for recommended section

      setState(() {
        // Map fetched documents to Property objects for featured properties
        featuredProperties = featuredSnapshot.docs.map((doc) {
          return Property.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();

        // Map fetched documents to Property objects for recommended properties
        recommendedProperties = recommendedSnapshot.docs.map((doc) {
          return Property.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();

        // Shuffle the recommended properties list
        recommendedProperties.shuffle(Random());

        // Initially display all featured properties
        displayedProperties = List.from(featuredProperties);

        // Set loading to false after fetching data
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching properties: $error');
      setState(() {
        isLoading = false; // Even if there's an error, stop loading
      });
    }
  }

  // Filter properties based on search query
  void filterProperties(String query) {
    final filteredProperties = featuredProperties.where((property) {
      return property.propertyName
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          property.location.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      displayedProperties =
          filteredProperties; // Update the displayed properties with the filtered ones
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      body: SingleChildScrollView(
        child: _banner(context),
      ),
    );
  }

  Widget _banner(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        // Banner Section
        Container(
          height: 300,
          width: width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/banner.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Find your best \nPlace near you",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: width * 0.6,
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[850]
                : Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Center(
            child: TextField(
              readOnly: true,
              onTap: () {
                _showSearchDialog(context);
              },
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
                hintText: "Search Your Place",
                hintStyle: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white54
                      : Colors.black54,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
              ),
            ),
          ),
        ),
        // Featured Properties Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "Featured",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: isLoading
                      ? List.generate(6, (index) => _loadingShimmer()) // Show 6 loading shimmers for featured
                      : displayedProperties.map((property) {
                          return PropertyCard2(
                            title: property.propertyName,
                            location: property.location,
                            price: property.propertyPrice,
                            imageUrl: property.photos.isNotEmpty
                                ? property.photos[0]
                                : 'https://via.placeholder.com/150', // Fallback image
                            type: property.propertyType,
                            rating:
                                4.5, // Static rating or dynamic if available
                            property: property, // Pass the Property model here
                          );
                        }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              // Recommended Section
              Text(
                "Recommended",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              // Recommended Properties
              isLoading
                  ? _loadingShimmer() // Show shimmer effect for recommended
                  : Column(
                      children: recommendedProperties.map((property) {
                        return PropertyCard(property: property);
                      }).toList(),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  void _showSearchDialog(BuildContext context) {
    final TextEditingController areaController = TextEditingController();
    final TextEditingController budgetController = TextEditingController();
    String? selectedPropertyType = "Room";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Search Filter'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Area Input
              TextField(
                controller: areaController,
                decoration: const InputDecoration(
                  labelText: 'Enter your area',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Budget Input
              TextField(
                controller: budgetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter your budget',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Property Type Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select property type',
                  border: OutlineInputBorder(),
                ),
                value: selectedPropertyType,
                items: ['Room', 'PG', 'Villa'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  selectedPropertyType = newValue;
                },
              ),
            ],
          ),
          actions: [
            // Cancel Button
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            // Search Button
            ElevatedButton(
              child: const Text('Search'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog

                // Navigate to the search screen with the collected data
                Get.toNamed(
                  '/search',
                  arguments: {
                    'area': areaController.text,
                    'budget': budgetController.text,
                    'propertyType': selectedPropertyType,
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  // Shimmer loading effect for property cards
  Widget _loadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: 200,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
