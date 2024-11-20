import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screen/dashboard/PropertyDetail.dart'; // Make sure to import GetX for navigation
import 'package:comfystay/models/resource.dart';

class FavCard extends StatelessWidget {
  final Property property; // Holds the property data

  const FavCard({super.key, required this.property}); // Constructor

  @override
  Widget build(BuildContext context) {
    // Define colors based on the current theme
    Color titleColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
    Color subtitleColor = Colors.grey[500]!; // Constant color for the subtitle
    Color priceColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: () {
        // Navigate to PropertyDetailScreen
        Get.to(() => PropertyDetailScreen(property: property));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 8, right: 8, top: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Subtle shadow
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            // Property Image with Favorite Icon
            Stack(
              children: [
                // Property Image
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: property.photos != null && property.photos!.isNotEmpty
                          ? NetworkImage(property.photos![0])
                          : const AssetImage("assets/images/roomcard.jpeg") as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
                // Favorite Icon Overlay
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        // Add favorite functionality if required
                      },
                    ),
                  ),
                ),
              ],
            ),
            // Property Details
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property Name and Type
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          property.propertyName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: titleColor,
                          ),
                          overflow: TextOverflow.ellipsis, // Handle overflow
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(20, 133, 115, 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          property.propertyType,
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Location and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_pin, color: Colors.grey, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            property.location,
                            style: TextStyle(color: subtitleColor, fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            "4.5", // Placeholder for rating
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: subtitleColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Price
                  Text(
                    "\$${property.propertyPrice} / night",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: priceColor,
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
