import 'package:carousel_slider/carousel_slider.dart';
import 'package:comfystay/components/PropertyCard3.dart';
import 'package:comfystay/models/resource.dart';
import 'package:comfystay/screen/dashboard/PropertyDetail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserListingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Listings",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: UserListings(),
    );
  }
}

class UserListings extends StatefulWidget {
  @override
  _UserListingsState createState() => _UserListingsState();
}

class _UserListingsState extends State<UserListings> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late Stream<QuerySnapshot> _userListingsStream;

  @override
  void initState() {
    super.initState();
    final currentUser = _auth.currentUser;

    // Check if the user is authenticated
    if (currentUser != null) {
      // Fetch listings where the user_id matches the current user's UID
      _userListingsStream = _firestore
          .collection('property_details')
          .where('user_id',
              isEqualTo: currentUser.uid) // Filter based on user_id
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = _auth.currentUser;

    // If the user is not authenticated, show a message
    if (currentUser == null) {
      return Center(child: Text("User not authenticated"));
    }

    return StreamBuilder<QuerySnapshot>(
      stream:
          _userListingsStream, // Use the filtered stream for the current user's listings
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("An error occurred."));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No properties found."));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            // Get the document data
            var propertyData =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;

            // Use the fromJson factory constructor to create the Property object
            Property property = Property.fromJson(propertyData);

            return PropertyCard3(
              propertyName: property.propertyName,
              location: property.location,
              price: property.propertyPrice,
              photos: property.photos,
              propertyType: property.propertyType,
              property: property, // Pass the entire Property object
            );
          },
        );
      },
    );
  }
}

class PropertyDetailPage extends StatelessWidget {
  final String propertyName;
  final String location;
  final String price;
  final List<String> photos;
  final String propertyType;

  const PropertyDetailPage({
    Key? key,
    required this.propertyName,
    required this.location,
    required this.price,
    required this.photos,
    required this.propertyType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              propertyName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              location,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Rs $price/month',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              propertyType,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            // Display images in a carousel
            Container(
              height: 250,
              child: photos.isEmpty
                  ? Center(child: Text("No images available"))
                  : CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 2.0,
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
          ],
        ),
      ),
    );
  }
}
