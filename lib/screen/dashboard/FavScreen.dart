import 'package:comfystay/components/FavCard.dart';
import 'package:comfystay/controllers/favorite_controller.dart';
import 'package:comfystay/models/resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Favscreen extends StatelessWidget {
  const Favscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the FavoriteController instance to access the favorites list
    final FavoriteController favoriteController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        // If there are no favorites, display a message
        if (favoriteController.favorites.isEmpty) {
          return const Center(
            child: Text("No favorites added yet."),
          );
        }

        // Display the list of favorite properties
        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: favoriteController.favorites.length,
          itemBuilder: (context, index) {
            Property property = favoriteController.favorites[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: FavCard(property: property), // Display property card
            );
          },
        );
      }),
    );
  }
}
