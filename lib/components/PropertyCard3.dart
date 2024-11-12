import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../models/resource.dart';  // Assuming this is where your Property model is located

import '../screen/dashboard/PropertyDetail.dart';  // Correct import for PropertyDetailScreen

class PropertyCard3 extends StatelessWidget {
  final String propertyName;
  final String location;
  final String price;
  final List<String> photos;
  final String propertyType;
  final Property property; // Pass the property object itself

  const PropertyCard3({
    Key? key,
    required this.propertyName,
    required this.location,
    required this.price,
    required this.photos,
    required this.propertyType,
    required this.property, // The Property data is now passed directly
  }) : super(key: key);

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
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 1.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 250,
                child: photos.isEmpty
                    ? Center(child: Text("No images available"))
                    : CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 1,
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
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(propertyName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Icon(Icons.location_on_sharp, size: 12,),
                        Text(location, style: TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                    Text("Rs $price/month", style: TextStyle(fontSize: 16)),
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
