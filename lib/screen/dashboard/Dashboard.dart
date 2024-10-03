import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:comfystay/components/PropertyCard.dart';
import 'package:comfystay/components/PropertyCard2.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black // Dark background for dark mode
          : Colors.white, // Light background for light mode
      body: SingleChildScrollView(
        child: _banner(context),
      ),
    );
  }

  Widget _banner(BuildContext context) {
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Find your best \nPlace near you",
                  style: const TextStyle(
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
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[850] // Darker shade for better contrast
                : Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Center(
            child: TextField(
              readOnly: true, // Make the text field uneditable and trigger onTap
              onTap: () {
                _showSearchDialog(context);
              },
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
                hintText: "Search Your Place",
                hintStyle: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white54
                      : Colors.black54,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
              ),
            ),
          ),
        ),
        // Rest of your widget layout remains the same...
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Featured",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white // Keep white for dark theme
                            : Colors.black, // Keep black for light theme
                      ),
                    ),
                    const SizedBox(height: 20),
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Keep white for dark theme
                      : Colors.black, // Keep black for light theme
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/propertydetail');
                },
                child: PropertyCard(),
              ),
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

  void _showSearchDialog(BuildContext context) {
    String? selectedPropertyType = "Room"; // Default selected value for dropdown

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Search Filter'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Enter your college',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter your budget',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select property type',
                  border: OutlineInputBorder(),
                ),
                value: selectedPropertyType,
                items: ['Room', 'PG', 'Villa'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  selectedPropertyType = newValue;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            ElevatedButton(
              child: const Text('Search'),
              onPressed: () {
                // Handle search logic here
                Get.toNamed('/search'); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
