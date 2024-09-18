import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListingTextField extends StatelessWidget {
  final String text;

  const ListingTextField({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: TextStyle(fontWeight: FontWeight.w600),),
          SizedBox(height: 8,),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              )
              
            ),
          ),
        ],
      ),
    );
  }
}