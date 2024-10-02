import 'package:flutter/material.dart';

class PropertyCard2 extends StatelessWidget {
  const PropertyCard2({super.key});

  @override
  Widget build(BuildContext context) {
    // Define colors based on the current theme
    Color titleColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
    Color locationColor = Colors.grey[500]!; // Keeping a constant color for the location
    Color priceColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;

    return Padding(
      padding: const EdgeInsets.only(right: 18.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5, // Set container width
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.5, // Set container width
              height: 250, // Set container height
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage("assets/images/roomcard.jpeg"), // Use AssetImage
                  fit: BoxFit.cover, // Ensures the image covers the entire container
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
                        child: Text(
                          "Rama's PG",
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
                        child: const Text(
                          "PG",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_pin, color: locationColor), // Static color for location icon
                          const SizedBox(width: 4),
                          Text(
                            "Shantinagar, Kathmandu",
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
                            "4.5",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: titleColor, // Dynamic rating text color
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "RS 8000/month",
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
