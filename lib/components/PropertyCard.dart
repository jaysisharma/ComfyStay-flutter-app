import 'package:comfystay/models/resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screen/dashboard/PropertyDetail.dart'; // Make sure to import GetX for navigation

class PropertyCard extends StatelessWidget {
  final Property property; // Holds the property data

  const PropertyCard({super.key, required this.property}); // Constructor

  @override
  Widget build(BuildContext context) {
    // Define colors based on the current theme
    Color titleColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
    Color subtitleColor = Colors.grey[500]!; // Constant color for the subtitle
    Color priceColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;

    return GestureDetector( // Wrap the entire card with GestureDetector
      onTap: () {
        // Navigate to PropertyDetailScreen
        Get.to(() => PropertyDetailScreen(property: property)); // Pass the resource to PropertyDetailScreen
      },
      child: Container(
        child: Column(
          children: [
            // Property Image
            Container(
              width: MediaQuery.of(context).size.width, // Set container width
              height: 250, // Set container height
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: property.photos != null && property.photos!.isNotEmpty
                      ? NetworkImage(property.photos![0]) // First photo URL
                      : const AssetImage("assets/images/roomcard.jpeg") as ImageProvider, // Fallback image
                  fit: BoxFit.cover, // Cover entire container
                ),
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
            ),
            const SizedBox(height: 10), // Spacing between image and text
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property Name and Type
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          property.propertyName, // Display property name
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: titleColor, // Dynamic title text color
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(20, 133, 115, 1),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          property.propertyType, // Display property type dynamically
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Property Location and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_pin, color: subtitleColor),
                          const SizedBox(width: 4),
                          Text(
                            "${property.location}", // Dynamic location from property
                            style: TextStyle(
                              color: titleColor, // Dynamic location text color
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            "4.5", // Placeholder for rating; you can replace it with a dynamic value if available
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: titleColor, // Dynamic rating text color
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Property Price
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Rs ${property.propertyPrice}/month", // Dynamic price from property
                      style: TextStyle(
                        color: priceColor, // Dynamic price text color
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
