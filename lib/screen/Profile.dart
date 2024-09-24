import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 158, 135),
        foregroundColor: Colors.white,
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAllNamed("/HomeScreen.dart"); // Navigate back to the home page and clear the navigation stack
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 19, 158, 135),
              borderRadius: BorderRadius.only(
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
                  backgroundColor: const Color.fromRGBO(90, 205, 184, 1),
                  child: Image.asset(
                      'assets/images/profile.png'), // Ensure the asset path is correct
                ),
                const SizedBox(height: 10),
                const Text(
                  'Abhishek Sah',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: (){
              Get.toNamed("/property");
            },
            child: _buildProfileMenu(
                "Update Profile", Icons.person),
          ),
          _buildProfileMenu("Add Parent", Icons.people),
          _buildProfileMenu("Add Teacher", Icons.people),
          _buildProfileMenu("Change Password", Icons.key),
          _buildProfileMenu("Help & Support", Icons.support_agent_rounded),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.dark_mode),
                        const SizedBox(width: 20),
                        const Text("Dark Mode", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    Switch(
                      value: isDarkMode,
                      onChanged: (bool value) {
                        print("Dark Mode Switch: $value");
                        setState(() {
                          isDarkMode = value;
                        });
                      },
                    ),
                  ],
                ),
                Divider(height: 8, color: Colors.grey[400]),
              ],
            ),
          ),
          _buildProfileMenu("Logout", Icons.logout),
        ],
      ),
    );
  }

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
                  Icon(icon),
                  const SizedBox(width: 20),
                  Text(name, style: const TextStyle(fontSize: 20)),
                ],
              ),
              const Icon(Icons.arrow_forward_ios_sharp),
            ],
          ),
          const SizedBox(height: 8),
          Divider(height: 8, color: Colors.grey[400]),
        ],
      ),
    );
  }
}