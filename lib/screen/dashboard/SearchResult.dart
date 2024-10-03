import 'package:comfystay/components/PropertyCard.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:  Text(
                    "Search Result",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              PropertyCard(),
              PropertyCard(),
              PropertyCard(),
              PropertyCard()
            ],
          ),
        ),
      ),
    );
  }
}
