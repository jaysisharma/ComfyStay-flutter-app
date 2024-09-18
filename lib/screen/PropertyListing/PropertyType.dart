import 'package:comfystay/components/CustomButton.dart';
import 'package:comfystay/components/ListingField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PropertyType extends StatelessWidget {
  const PropertyType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title:
            Text('Choose Property Type', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0, // Remove default AppBar shadow
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Get.toNamed("/listing");
                },
                child: _buildtype("PG", "pg.png")),
            _buildtype("Room", "room.png"),
            _buildtype("Villa", "villa.png"),
          ],
        ),
      ),
    );
  }

  Widget _buildtype(String type, String image) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          children: [
            Image.asset(
              "images/${image}",
              height: 50,
            ),
            SizedBox(width: 20), // Add space between image and text
            Text(
              type,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PGListing extends StatelessWidget {
  const PGListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PG Listing"),
      ),
      body: Column(
        children: [
          ListingTextField(
            text: "PG Name",
          ),
          ListingTextField(
            text: "PG Description",
          ),
          ListingTextField(
            text: "PG Price/Month",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: GestureDetector(
                onTap: () {
                  Get.toNamed("/conditions");
                },
                child: CustomButton(text: "Next")),
          )
        ],
      ),
    );
  }
}
