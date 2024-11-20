import 'package:comfystay/models/resource.dart';
import 'package:comfystay/screen/dashboard/PropertyDetail.dart';
import 'package:flutter/material.dart';


class PropertyCard2 extends StatelessWidget {
  final Property property;

  const PropertyCard2({
    super.key,
    required this.property, required String title, required String location, required String imageUrl, required String price, required String type, required double rating,
  });

  @override
  Widget build(BuildContext context) {
    Color titleColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    Color locationColor = Colors.grey[500]!;
    Color priceColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Padding(
      padding: const EdgeInsets.only(right: 18.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PropertyDetailScreen(property: property),
            ),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 1.4,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(property.photos.isNotEmpty
                        ? property.photos[0]
                        : 'https://via.placeholder.com/150'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 10),
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
                            property.propertyName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: titleColor,
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          // width: 40,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(20, 133, 115, 1),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              property.propertyType,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_pin, color: locationColor),
                            const SizedBox(width: 4),
                            Text(
                              property.location,
                              style: TextStyle(
                                color: titleColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              '4.5', // Static rating, can be dynamic later
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: titleColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Rs ${property.propertyPrice}/month",
                        style: TextStyle(
                          color: priceColor,
                        ),
                      ),
                    ),
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
