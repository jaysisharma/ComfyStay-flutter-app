import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:comfystay/components/PropertyCard.dart';
import 'package:comfystay/models/resource.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final arguments = Get.arguments ?? {};
  late final String area;
  late final String budget;
  late final String propertyType;

  List<Property> searchResults = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Retrieve search parameters
    area = arguments['area'] ?? '';
    budget = arguments['budget'] ?? '';
    propertyType = arguments['propertyType'] ?? '';

    // Fetch properties based on the search criteria
    fetchProperties();
  }

  Future<void> fetchProperties() async {
    try {
      print('Querying Firestore with: Area - $area, Budget - $budget, PropertyType - $propertyType');

      // If budget is provided, attempt to parse it to a double
      double parsedBudget = double.tryParse(budget) ?? double.infinity;

      // Construct the Firestore query based on available parameters
      Query query = FirebaseFirestore.instance.collection('property_details');

      if (area.isNotEmpty) {
        query = query.where('location', isEqualTo: area);
      }

      if (propertyType.isNotEmpty) {
        query = query.where('type', isEqualTo: propertyType);
      }

      if (parsedBudget != double.infinity) {
        query = query.where('property_price', isLessThanOrEqualTo: parsedBudget);
      }

      // Execute the query and get the results
      QuerySnapshot snapshot = await query.get();
      
      print('Documents found: ${snapshot.docs.length}');

      setState(() {
        searchResults = snapshot.docs.map((doc) {
          print('Property data: ${doc.data()}');
          return Property.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching properties: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : searchResults.isEmpty
                ? const Center(
                    child: Text(
                      'No properties found.',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final property = searchResults[index];
                      return PropertyCard(property: property);
                    },
                  ),
      ),
    );
  }
}
