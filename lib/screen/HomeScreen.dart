// import 'package:comfystay/screen/Inbox.dart';
// import 'package:comfystay/screen/Profile.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

// // Controller for managing the bottom navigation index
// class BottomNavController extends GetxController {
//   // Reactive variable for the active bottom nav index
//   var currentIndex = 0.obs;

//   // Function to update the active index
//   void changeIndex(int index) {
//     currentIndex.value = index;
//   }
// }

// class HomeScreen extends StatelessWidget {
//   HomeScreen({super.key}) {
//     // Ensure BottomNavController is initialized when the HomeScreen is created
//     Get.put(BottomNavController());
//   }

//   // List of icons for the bottom navigation bar
//   final iconList = <IconData>[
//     Icons.home,
//     Icons.favorite,
//     Icons.search,
//     Icons.person,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final BottomNavController bottomNavController = Get.find();

//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Action for FloatingActionButton
//         },
//         child: const Icon(Icons.add),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomNavigation(), // Separate widget for bottom nav
//       body: Obx(() {
//         return IndexedStack(
//           index: bottomNavController.currentIndex.value,
//           children: const [
//             HomeTab(),
//             FavoriteTab(),
//             Inbox(),
//             ProfileScreen(),
//           ],
//         );
//       }),
//     );
//   }
// }

// // Bottom Navigation Bar Widget
// class BottomNavigation extends StatelessWidget {
//   final iconList = <IconData>[
//     Icons.home,
//     Icons.favorite,
//     Icons.search,
//     Icons.person,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final BottomNavController bottomNavController = Get.find();

//     return Obx(() => AnimatedBottomNavigationBar(
//           icons: iconList,
//           activeIndex: bottomNavController.currentIndex.value,
//           gapLocation: GapLocation.center,
//           notchSmoothness: NotchSmoothness.verySmoothEdge,
//           onTap: (index) => bottomNavController.changeIndex(index),
//           activeColor: Colors.green,
//           inactiveColor: Colors.grey,
//           splashColor: Colors.greenAccent,
//         ));
//   }
// }

// // Screen 1: Home Tab
// class HomeTab extends StatelessWidget {
//   const HomeTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text("Home Screen", style: TextStyle(fontSize: 24)),
//     );
//   }
// }

// // Screen 2: Favorite Tab
// class FavoriteTab extends StatelessWidget {
//   const FavoriteTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text("Favorite Screen", style: TextStyle(fontSize: 24)),
//     );
//   }
// }

// // Screen 3: Search Tab
// class SearchTab extends StatelessWidget {
//   const SearchTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text("Search Screen", style: TextStyle(fontSize: 24)),
//     );
//   }
// }

// // Screen 4: Profile Tab
// class ProfileTab extends StatelessWidget {
//   const ProfileTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text("Profile Screen", style: TextStyle(fontSize: 24)),
//     );
//   }
// }

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Track the current index
  double _iconOffsetX = 50; // Initial horizontal position of the white background

  void _onIconTapped(int index) {
    setState(() {
      _currentIndex = index;
      _iconOffsetX = index * (MediaQuery.of(context).size.width / 4) + 15; // Adjust based on screen width
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(child: Text('Main Content Area', style: TextStyle(fontSize: 24))),
          
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 80, // Adjusted height for better layout
              color: Colors.blue,
              child: Stack(
                children: [
                  // Animated white background
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    left: _iconOffsetX,
                    bottom: 50, // Align it closer to the bottom of the nav
                    child: Container(
                      width: 60, // Adjust width based on number of items
                      height: 60, // Match height of the bottom nav
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        _currentIndex == 0
                            ? Icons.home
                            : _currentIndex == 1
                                ? Icons.search
                                : _currentIndex == 2
                                    ? Icons.notifications
                                    : Icons.person,
                        color: Colors.blue, // Change icon color to match the nav items
                      ),
                    ),
                  ),
                  // Navigation items
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => _onIconTapped(0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.home, color: Colors.white),
                            Text('Home', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _onIconTapped(1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search, color: Colors.white),
                            Text('Search', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _onIconTapped(2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.notifications, color: Colors.white),
                            Text('Notifications', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _onIconTapped(3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person, color: Colors.white),
                            Text('Profile', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
