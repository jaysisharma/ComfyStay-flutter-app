import 'package:comfystay/components/PropertyCard.dart';
import 'package:comfystay/components/PropertyCard2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: _banner(context)),
    );
  }

  Widget _banner(context) {
    final double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          height: 300,
          width: width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/banner.png"), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Find your best \nPlace near you",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: width * 0.6, // Reduced width to 60% of the screen width
          height: 50, // Height remains the same
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.search),
                hintText: "Search Your Place",
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(28),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ), // Adjust padding here
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Featured",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          PropertyCard2(),
                          PropertyCard2(),
                          PropertyCard2(),
                          PropertyCard2(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Recommended",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              PropertyCard(),
              PropertyCard(),
              PropertyCard(),
              PropertyCard(),
              PropertyCard(),
            ],
          ),
        ),
      ],
    );
  }
}
