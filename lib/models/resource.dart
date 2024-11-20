class Property {
  final String propertyId;
  final String propertyName;
  final String location;
  final String propertyPrice;
  final List<String> photos;
  final String propertyType;
  final String propertyDescription;
  final List<String> conditions;
  final List<String> initialRequirements;
  final String contact;
  final List<String> whatsIncluded;
  final String user_id;

  // Constructor
  Property({
    required this.propertyId,
    required this.propertyName,
    required this.location,
    required this.propertyPrice,
    required this.photos,
    required this.propertyType,
    required this.propertyDescription,
    required this.conditions,
    required this.initialRequirements,
    required this.contact,
    required this.whatsIncluded,
    required this.user_id,
  });

  // fromJson method to convert Firestore data into a Property object
  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      propertyId: json['property_id'] ?? '',
      user_id: json["user_id"].toString(),
      propertyName: json['property_name'] ?? '',
      location: json['location'] ?? '',
      // Ensure propertyPrice is converted to a string
      propertyPrice: (json['property_price'] is int)
          ? json['property_price'].toString()
          : json['property_price'] ?? '',
      photos: List<String>.from(json['photos'] ?? []),
      propertyType: json['type'] ?? '',
      propertyDescription: json['property_description'] ?? '',
      conditions: List<String>.from(json['conditions'] ?? []),
      initialRequirements: List<String>.from(json['initialRequirements'] ?? []),
      contact: json['contact'] ?? '',
      whatsIncluded: List<String>.from(json['whatsIncluded'] ?? []),
    );
  }
}
