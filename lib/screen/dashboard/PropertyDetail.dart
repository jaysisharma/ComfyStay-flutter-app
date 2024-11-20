import 'package:carousel_slider/carousel_slider.dart';
import 'package:comfystay/components/CustomButton.dart';
import 'package:comfystay/controllers/favorite_controller.dart';
import 'package:comfystay/screen/dashboard/Message_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

import '../../models/resource.dart';

class PropertyDetailScreen extends StatelessWidget {
  final Property property;
  final FavoriteController favoriteController = Get.put(FavoriteController());

  PropertyDetailScreen({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  // SizedBox(
                  //   height: 40,
                  // ),
                  Container(
                    width: double.infinity,
                    height: 250,
                    child: property.photos.isEmpty
                        ? Center(child: Text("No images available"))
                        : CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: true,
                              // aspectRatio: 1,
                              viewportFraction: 1.0,
                            ),
                            items: property.photos.map((photo) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(photo),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                  ),
                  Positioned(
                    top: 0,
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
                         Obx(() => IconButton(
                              iconSize: 40,
                              onPressed: () {
                                favoriteController.toggleFavorite(property);
                              },
                              icon: Icon(
                                favoriteController.isFavorite(property)
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: Colors.red,
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rs ${property.propertyPrice}/month",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () {
                            // Share property details when tapped
                            Share.share(
                              "Check out this property: ${property.propertyName}\n"
                              "Location: ${property.location}\n"
                              "Price: Rs ${property.propertyPrice}/month\n"
                              "Description: ${property.propertyDescription}",
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      property.propertyName,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      property.propertyDescription,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "${property.location}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Amenities",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
              _buildAmenitiesGrid(property.whatsIncluded),
              const SizedBox(height: 20),
              _buildConditions(property.conditions),
              const SizedBox(height: 20),
              _whatsIncluded(property.whatsIncluded),
              const SizedBox(height: 20),
              _buildInitialRequirements(property.initialRequirements),
              const SizedBox(height: 20),
              _buildContact(property.contact),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  User? user = FirebaseAuth.instance.currentUser;

                  // Check if the user is logged in
                  if (user == null) {
                    // If not logged in, show an error message
                    Get.snackbar(
                        "Error", "You must be logged in to contact the owner.");
                    return;
                  }

                  String currentUserId = user.uid;
                  print("Current User ID: $currentUserId");

                  // Check if the current user is trying to message themselves
                  if (currentUserId == property.user_id) {
                    // Show an error message if the user is the property owner
                    Get.snackbar("Error", "You cannot message yourself.",
                        backgroundColor: Colors.orange);
                    return;
                  }

                  // Navigate to the message page if the user is not the property owner
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MessagePage(userId: property.user_id, receiverId: currentUserId, imageUrl: property.photos[0], propertyName: property.propertyName,),
                    ),
                  );
                },
                child: CustomButton(text: 'Contact Now'),
              ),
            ],
          ),
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
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          childAspectRatio: 5,
        ),
        itemCount: amenities.length,
        itemBuilder: (context, index) {
          final amenity = amenities[index];
          return Column(
            children: [
              // Expanded(
              //   child: Container(
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(12),
              //       image: DecorationImage(
              //         image: AssetImage(
              //             "assets/images/${amenity.toLowerCase().replaceAll(' ', '_')}.png"), // Assuming image names match amenity names
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 5),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Conditions",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 10),
          for (var condition in conditions)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '- ${condition}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
              ],
            ),
        ],
      ),
    );
  }

  Widget _whatsIncluded(List<String> whatsIncluded) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What's Included",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 10),
          for (var item in whatsIncluded)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '- ${item}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildInitialRequirements(List<String> initialRequirements) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Initial Requirements",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 10),
          for (var requirement in initialRequirements)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '- ${requirement}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildContact(String contactNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Contact Us",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            "Phone: $contactNumber",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
