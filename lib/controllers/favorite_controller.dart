import 'package:get/get.dart';
import '../../models/resource.dart';

class FavoriteController extends GetxController {
  // The RxList will hold the favorite properties
  final RxList<Property> _favorites = <Property>[].obs;

  // Expose the favorites list for the UI to use
  List<Property> get favorites => _favorites;

  // Check if the property is in the favorites list
  bool isFavorite(Property property) => _favorites.contains(property);

  // Toggle the favorite status of a property
  void toggleFavorite(Property property) {
    if (isFavorite(property)) {
      _favorites.remove(property); // Remove from favorites
    } else {
      _favorites.add(property); // Add to favorites
    }
  }
}
