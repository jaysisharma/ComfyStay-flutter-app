import 'package:comfystay/components/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PropertyDetailScreen extends StatelessWidget {
  const PropertyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of amenities (Image and Text)
    final List<Map<String, String>> amenities = [
      {"image": "assets/images/room.png", "name": "Wi-Fi"},
      {"image": "assets/images/villa.png", "name": "Swimming Pool"},
      {"image": "assets/images/room.png", "name": "Parking"},
      {"image": "assets/images/villa.png", "name": "Gym"},
      {"image": "assets/images/room.png", "name": "Air Conditioning"},
      {"image": "assets/images/villa.png", "name": "Laundry"},
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/images/roomcard.jpeg"), // Replace with your image path
                      fit: BoxFit.cover,
                      opacity: .9,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
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
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rs 15,000/month",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.share),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Royal Villa",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "A villa with a swimming pool and a premium feel, offering ultimate luxury and comfort.",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Amenities",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            _buildAmenitiesGrid(amenities),
            SizedBox(
              height: 20,
            ),
            _buildConditions(),
            SizedBox(
              height: 20,
            ),
            _whatsIncluded(),
            SizedBox(
              height: 20,
            ),
          __buildContact(),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){
              Get.toNamed('/messagepage');
            },
            child: CustomButton(text: 'Contact Now'))
          ],
        ),
      ),
    );
  }

  Widget _buildAmenitiesGrid(List<Map<String, String>> amenities) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: GridView.builder(
        shrinkWrap: true, // Important to make GridView work inside a ScrollView
        physics:
            const NeverScrollableScrollPhysics(), // Disable scrolling inside GridView
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 columns
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
          childAspectRatio: 0.8, // Adjust to control image/text ratio
        ),
        itemCount: amenities.length,
        itemBuilder: (context, index) {
          final amenity = amenities[index];
          return Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(
                          amenity['image']!), // Fetch image from the list
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                amenity['name']!, // Fetch name from the list
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

  Widget _buildConditions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Conditions",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(height: 10),
        Text(
          "1. No smoking allowed in the villa.",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 5),
        Text(
          "2. No pets allowed in the villa.",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 5),
        Text(
          "3. No alcohol or drugs allowed in the villa.",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 5),
        Text(
          "4. No children under 18 allowed in the villa.",
        )
      ]),
    );
  }

  Widget _whatsIncluded() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "What's Included",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 10),
          Text(
            "1. 2 bedrooms, 2 bathrooms, and 1 living room.",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5),
          Text(
            "2. Private balcony with views of the village.",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5),
          Text(
            "3. Private swimming pool with in-ground pool.",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ]));
  }
  Widget __buildContact(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Contact Us",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      SizedBox(height: 10),
      Text(
        "Phone: +91 1234567890",
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      SizedBox(height: 5),
      Text(
        "Email:  contact@example.com",
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
    ]));
  
}


}
