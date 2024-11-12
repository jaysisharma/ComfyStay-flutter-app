class Property {
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

  // Constructor
  Property({
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
  });

  // fromJson method to convert Firestore data into a Property object
  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      propertyName: json['property_name'] ?? '',
      location: json['location'] ?? '',
      propertyPrice: json['property_price'] ?? '',
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
