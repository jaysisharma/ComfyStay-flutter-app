import 'package:comfystay/screen/dashboard/Dashboard.dart';
import 'package:comfystay/screen/dashboard/FavScreen.dart';
import 'package:comfystay/screen/dashboard/Inbox.dart';
import 'package:comfystay/screen/profile/Profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controller for managing the bottom navigation index
class BottomNavController extends GetxController {
  var currentIndex = 0.obs;

  // Function to update the active index
  void changeIndex(int index) {
    currentIndex.value = index;
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key}) {
    Get.put(BottomNavController());
  }

  // List of icons for the bottom navigation bar
  final iconList = <IconData>[
    Icons.home,
    Icons.favorite,
    Icons.inbox,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController = Get.find();

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigation(),
      body: Obx(() {
        return IndexedStack(
          index: bottomNavController.currentIndex.value,
          children: const [
            Dashboard(),
            Favscreen(),
            Inbox(),
            ProfileScreen(),
          ],
        );
      }),
    );
  }
}

// Bottom Navigation Bar Widget with Floating Active Icon
class BottomNavigation extends StatelessWidget {
  final iconList = <IconData>[
    Icons.home,
    Icons.favorite,
    Icons.message,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController = Get.find();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Curved background under the active icon
        Positioned(
          bottom: -20, // Positioning the curve slightly below
          left: 0,
          right: 0,
          child: _buildCurve(context),
        ),
        Obx(() => BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(iconList[0]),
                  label: _getLabel(0),
                ),
                BottomNavigationBarItem(
                  icon: Icon(iconList[1]),
                  label: _getLabel(1),
                ),
                BottomNavigationBarItem(
                  icon: Icon(iconList[2]),
                  label: _getLabel(2),
                ),
                BottomNavigationBarItem(
                  icon: Icon(iconList[3]),
                  label: _getLabel(3),
                ),
              ],
              currentIndex: bottomNavController.currentIndex.value,
              onTap: (index) => bottomNavController.changeIndex(index),
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed, // Fixed bar without animation
            )),
      ],
    );
  }

  // Function to build the curved background
  Widget _buildCurve(BuildContext context) {
    return ClipPath(
      clipper: _CustomClipper(), // Custom path for the curve
      child: Container(
        height: 80,
        color: Colors.white,
      ),
    );
  }

  // Labels for the active tabs
  String _getLabel(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Favorite';
      case 2:
        return 'Inbox';
      case 3:
        return 'Profile';
      default:
        return '';
    }
  }
}

// Custom Clipper for the curve
class _CustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.7,
        size.width * 0.65, 0); // Creates the curved effect
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
