import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:comfystay/utils/custom_icons.dart'; // Import your custom icons

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900]  // Dark background
          : Colors.grey[100], // Light background
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: const Text('Profile'),
        leading: IconButton(
          icon: Icon(CustomIcons.backArrow, color: Colors.white), // Back arrow icon
          onPressed: () {
            Get.offAllNamed("/dashboard");
          },
        ),
      ),
      body: Column(
        children: [
          // Profile header
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Image.asset('assets/images/profile.png'),
                ),
                const SizedBox(height: 10),
                Text(
                  'Abhishek Sah',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Profile menu items
          GestureDetector(
            onTap: () {
              Get.toNamed("/property");
            },
            child: _buildProfileMenu("List Your Property", CustomIcons.construction),
          ),
          _buildProfileMenu("Your Listing", CustomIcons.list),
          _buildProfileMenu("Add Teacher", CustomIcons.addTeacher),
          _buildProfileMenu("Change Password", CustomIcons.changePassword),
          _buildProfileMenu("Help & Support", CustomIcons.helpSupport),

          // Dark mode switch
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(CustomIcons.darkMode, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black), // Dark mode icon
                    const SizedBox(width: 20),
                    Text("Dark Mode", style: TextStyle(fontSize: 20, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
                  ],
                ),
                Switch(
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (bool value) {
                    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                  },
                ),
              ],
            ),
          ),
          _buildProfileMenu("Logout", CustomIcons.logout),
        ],
      ),
    );
  }

  // Profile menu builder
  Widget _buildProfileMenu(String name, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black), // Icon color based on theme
                  const SizedBox(width: 20),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
              Icon(CustomIcons.arrowForward, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black), // Arrow icon
            ],
          ),
          const SizedBox(height: 8),
          Divider(height: 8, color: Colors.grey[400]),
        ],
      ),
    );
  }
}
