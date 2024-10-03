import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String hint;
  const CustomTextField({super.key, required this.label, required this.icon, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
              height: 10), // Add some vertical space between label and text field
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // Background color of the TextField
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(icon,color: Colors.black,),
                border: InputBorder.none, // Removes the default border
                contentPadding: EdgeInsets.all(16.0),
                hintText: hint,
              ),
            ),
          )
        ],
      ),
    );
  }
}
