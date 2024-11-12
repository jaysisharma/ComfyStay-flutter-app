// controllers/favorite_controller.dart
import 'package:get/get.dart';
import '../../models/resource.dart';

class FavoriteController extends GetxController {
  final RxList<Property> _favorites = <Property>[].obs;

  List<Property> get favorites => _favorites;

  bool isFavorite(Property property) => _favorites.contains(property);

  void toggleFavorite(Property property) {
    if (isFavorite(property)) {
      _favorites.remove(property);
    } else {
      _favorites.add(property);
    }
  }
}
