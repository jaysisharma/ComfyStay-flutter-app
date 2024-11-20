import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comfystay/models/resource.dart';  // Assuming this is where your Property model is located
import '../screen/dashboard/PropertyDetail.dart';  // Correct import for PropertyDetailScreen

class PropertyCard3 extends StatelessWidget {
  final String propertyName;
  final String location;
  final String price;
  final List<String> photos;
  final String propertyType;
  final Property property; // The Property data passed directly

  const PropertyCard3({
    Key? key,
    required this.propertyName,
    required this.location,
    required this.price,
    required this.photos,
    required this.propertyType,
    required this.property, // The Property data is now passed directly
  }) : super(key: key);

  // Function to delete the property from Firestore
  Future<void> _deleteProperty(String propertyId, BuildContext context) async {
    try {
      // Show a confirmation dialog before deleting
      bool confirmDelete = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Delete Property"),
                content: Text("Are you sure you want to delete this property?"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false); // Cancel
                    },
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true); // Confirm
                    },
                    child: Text("Delete"),
                  ),
                ],
              );
            }) ??
            false;

      if (confirmDelete) {
        // Proceed with the deletion from Firestore
        await FirebaseFirestore.instance
            .collection('property_details')
            .doc(propertyId) // Use the property ID to identify the document
            .delete();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Property deleted successfully!")),
        );
      }
    } catch (e) {
      print("Error deleting property: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting property")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the PropertyDetailScreen and pass the property data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailScreen(property: property),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 1.1,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 4), // Changes the position of the shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Carousel
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: photos.isEmpty
                    ? Center(
                        child: Text(
                          "No images available",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 1.5,
                          viewportFraction: 1.0,
                        ),
                        items: photos.map((photo) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(photo),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
              ),

              // Property Details and Delete Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Property Name
                        Text(
                          propertyName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4),
                        // Property Location
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_sharp,
                              size: 16,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 4),
                            Text(
                              location,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        // Property Price
                        Text(
                          "Rs $price/month",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                    // Delete Button - Positioned at the top-right corner
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red, size: 28),
                      onPressed: () {
                        _deleteProperty(property.propertyId, context); // Delete the property when tapped
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
