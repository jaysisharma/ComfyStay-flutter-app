import 'package:flutter/material.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width, // Set container width
            height: 250, // Set container height
            decoration: BoxDecoration(
              image: const DecorationImage(
                image:
                    AssetImage("assets/images/roomcard.jpeg"), // Use AssetImage
                fit: BoxFit
                    .cover, // Ensures the image covers the entire container
              ),
              borderRadius: BorderRadius.circular(10), // Apply rounded corners
            ),
          ),
          const SizedBox(height: 10), // Optional spacing between image and text
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: const Text(
                        "Rama's PG",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(20, 133, 115, 1),
                          borderRadius: BorderRadius.circular(9)),
                      alignment: Alignment.center,
                      child: Text(
                        "PG",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_pin, color: Colors.grey[500]),
                        Text(
                          "Shantinagar, Kathmandu",
                          style: TextStyle(color: Colors.grey[500]),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 4,),
                        Text(
                          "4.5",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("RS 8000/month"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
