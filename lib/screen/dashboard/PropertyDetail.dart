import 'package:comfystay/components/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/resource.dart';

class PropertyDetailScreen extends StatelessWidget {
  final Resource resource; // Accept resource as a parameter

  const PropertyDetailScreen({Key? key, required this.resource})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          resource.photos != null && resource.photos!.isNotEmpty
                              ? resource.photos![0]
                              : 'assets/images/roomcard.jpeg'),
                      fit: BoxFit.cover,
                      opacity: .9,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 15,
                  right: 15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Displaying the price dynamically
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rs ${resource.pricePerMonth}/month",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.share),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    resource.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "${resource.description}",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 15),
                  // Displaying the address dynamically
                  Text(
                    "${resource.address.street}, ${resource.address.city}",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Amenities",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            _buildAmenitiesGrid(resource.amenities), // Use amenities from resource
            SizedBox(height: 20),
            _buildConditions(resource.conditions),
            SizedBox(height: 20),
            _whatsIncluded(resource.whatsIncluded),
            SizedBox(height: 20),
            __buildContact(resource.contactNumber),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.toNamed('/messagepage');
              },
              child: CustomButton(text: 'Contact Now'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmenitiesGrid(List<String> amenities) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
          childAspectRatio: 0.8,
        ),
        itemCount: amenities.length,
        itemBuilder: (context, index) {
          final amenity = amenities[index];
          return Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/images/${amenity.toLowerCase().replaceAll(' ', '_')}.png"), // Assuming image names match amenity names
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                amenity,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildConditions(List<String> conditions) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Conditions",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(height: 10),
        for (var condition in conditions)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                condition,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5),
            ],
          ),
      ]),
    );
  }

  Widget _whatsIncluded(List<String> whatsIncluded) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "What's Included",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(height: 10),
        for (var item in whatsIncluded)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5),
            ],
          ),
      ]),
    );
  }

  Widget __buildContact(String contactNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Contact Us",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(height: 10),
        Text(
          "Phone: $contactNumber",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ]),
    );
  }
}
