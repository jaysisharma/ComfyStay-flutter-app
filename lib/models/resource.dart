class Resource {
  final String id;
  final String name;
  final String description;
  final double pricePerMonth;
  final List<String> conditions;
  final List<String> whatsIncluded;
  final List<String> initialRequirements;
  final List<String>? photos; // Make this optional
  final String contactNumber;
  final String propertyType;
  final List<String> amenities; // New field for amenities
  final bool featured;
  final bool recommended;
  final Address address; // New field for address

  Resource({
    required this.id,
    required this.name,
    required this.description,
    required this.pricePerMonth,
    required this.conditions,
    required this.whatsIncluded,
    required this.initialRequirements,
    this.photos,
    required this.contactNumber,
    required this.propertyType,
    required this.amenities,
    required this.featured,
    required this.recommended,
    required this.address, // Include address in the constructor
  });

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      pricePerMonth: json['pricePerMonth'].toDouble(),
      conditions: List<String>.from(json['conditions']),
      whatsIncluded: List<String>.from(json['whatsIncluded']),
      initialRequirements: List<String>.from(json['initialRequirements']),
      photos: json['photos'] != null ? List<String>.from(json['photos']) : null,
      contactNumber: json['contactNumber'],
      propertyType: json['propertyType'],
      amenities: List<String>.from(json['amenities']),
      featured: json['featured'] ?? false,
      recommended: json['recommended'] ?? false,
      address: Address.fromJson(json['address']), // Parse address
    );
  }
}

class Address {
  final String street;
  final String city;

  Address({
    required this.street,
    required this.city,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      city: json['city'],
    );
  }
}
