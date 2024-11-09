import 'package:comfystay/components/PropertyCard.dart';
import 'package:flutter/material.dart';
import '../../models/resource.dart';
import '../../services/resource_service.dart';
// Assuming PropertyCard is in the same directory

class PropertyList extends StatefulWidget {
  @override
  _PropertyListState createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {
  late Future<List<Resource>> futureResources;

  @override
  void initState() {
    super.initState();
    futureResources = ResourceService().fetchResources();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Listings'),
      ),
      body: FutureBuilder<List<Resource>>(
        future: futureResources,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No properties found.'));
          } else {
            List<Resource> resources = snapshot.data!;
            return ListView.builder(
              itemCount: resources.length,
              itemBuilder: (context, index) {
                final resource = resources[index];
                return PropertyCard(resource: resource); // Pass the resource
              },
            );
          }
        },
      ),
    );
  }
}
