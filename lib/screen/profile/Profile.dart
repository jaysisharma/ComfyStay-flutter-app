import 'dart:io'; // Import this for File
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:comfystay/utils/custom_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _profileImageUrl = ''; // Store the URL of the profile image
  final ImagePicker _picker = ImagePicker();
  User? _user;
  String _email = ''; // Variable to store user email

  @override
  void initState() {
    super.initState();
    _fetchUserProfile(); // Fetch user profile on initialization
  }

  // Fetch user profile data
  Future<void> _fetchUserProfile() async {
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(_user!.uid)
            .get();
        setState(() {
          _profileImageUrl =
              userDoc['profileImage'] ?? ''; // Fetch the profile image URL
          _email = _user!.email ?? ''; // Fetch the user's email
        });
      } catch (e) {
        print("Error fetching user profile: $e");
      }
    }
  }

  // Function to pick an image from the gallery
  Future<void> _changeProfileImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      String downloadUrl = await _uploadImageToStorage(image.path);
      if (downloadUrl.isNotEmpty) {
        await _updateUserProfile(downloadUrl);
      }
    }
  }

  // Upload the image to Firebase Storage
  Future<String> _uploadImageToStorage(String imagePath) async {
    File file = File(imagePath);
    try {
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref('profile_images/${_user!.uid}.jpg') // Create a unique file name
          .putFile(file);
      return await snapshot.ref.getDownloadURL(); // Get the download URL
    } catch (e) {
      print("Error uploading image: $e");
      return ''; // Return empty if upload fails
    }
  }

  // Update the user profile with the new image URL
  Future<void> _updateUserProfile(String imageUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .update({'profileImage': imageUrl});
      setState(() {
        _profileImageUrl = imageUrl; // Update local state
      });
    } catch (e) {
      print("Error updating user profile: $e");
    }
  }

  // Logout function
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut(); // Sign out from Firebase

      // Clear the login state in Shared Preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');

      Get.offNamed('/login'); // Navigate to login screen after logging out
    } catch (e) {
      print("Error during logout: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900] // Dark background
          : Colors.grey[100], // Light background
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          // Profile header
          GestureDetector(
            onTap:
                _changeProfileImage, // Allow tapping the icon to change the profile image
            child: Container(
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
                  Stack(
                    alignment: Alignment
                        .bottomRight, // Align the edit icon to the bottom right
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        backgroundImage: _profileImageUrl.isNotEmpty
                            ? NetworkImage(
                                _profileImageUrl) // Display the new profile image
                            : const AssetImage('assets/images/profile.png')
                                as ImageProvider<Object>,
                      ),
                      GestureDetector(
                        onTap:
                            _changeProfileImage, // Allow tapping the icon to change the profile image
                        child: Container(
                          padding: const EdgeInsets.all(
                              6), // Padding around the icon
                          decoration: BoxDecoration(
                            color:
                                Colors.white, // Background color for the icon
                            borderRadius: BorderRadius.circular(
                                50), // Circular background
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(
                                    0, 3), // Changes position of shadow
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.edit, // Use the edit icon
                            color: Theme.of(context).primaryColor, // Icon color
                            size: 20, // Icon size
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _user?.email ??
                        'User Name', // Display user name, fallback to a default name
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _email, // Display user email
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey), // Style the email text
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Profile menu items
          GestureDetector(
            onTap: () {
              Get.toNamed("/property");
            },
            child: _buildProfileMenu(
                "List Your Property", CustomIcons.construction),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed("/yourlisting");
            },
            child: _buildProfileMenu("Your Listing", CustomIcons.list),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed("/change");
            },
            child: _buildProfileMenu(
                "Change Password", CustomIcons.changePassword),
          ),
          _buildProfileMenu("Help & Support", CustomIcons.helpSupport),

          // Dark mode switch
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(CustomIcons.darkMode,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black), // Dark mode icon
                    const SizedBox(width: 20),
                    Text("Dark Mode",
                        style: TextStyle(
                            fontSize: 20,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black)),
                  ],
                ),
                Switch(
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (bool value) {
                    Get.changeThemeMode(
                        value ? ThemeMode.dark : ThemeMode.light);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 0),
            child: Divider(height: 8, color: Colors.grey[400]),
          ),

          GestureDetector(
            onTap: _logout, // Call the logout function here
            child: _buildProfileMenu("Logout", CustomIcons.logout),
          ),
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
                  Icon(icon,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black), // Icon color based on theme
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
              Icon(CustomIcons.arrowForward,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black), // Arrow icon
            ],
          ),
          const SizedBox(height: 8),
          Divider(height: 8, color: Colors.grey[400]),
        ],
      ),
    );
  }
}
