import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Inbox extends StatelessWidget {
  const Inbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  "Inbox",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _messageCard(),
          _messageCard(),
          _messageCard()
        ],
      ),
    );
  }

  Widget _messageCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Added padding for spacing
      child: Column(
        children: [
          
          GestureDetector(
            onTap: () {
              Get.toNamed('/messagepage');
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40, // Adjusted to a reasonable size
                  backgroundImage: AssetImage(
                      "assets/images/roomcard.jpeg"), // Correct image usage
                ),
                SizedBox(width: 10), // Add spacing between image and text
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to the left
                    children: [
                      Text(
                        "Room Card",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Message details go here",
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 10),
                Row(children: [
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    child: Text(
                      "1",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 5),
                ])
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
