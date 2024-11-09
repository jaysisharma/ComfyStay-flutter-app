import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  const CustomButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: double.infinity, // Full width
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor, // Adapt to theme's primary color
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black.withOpacity(0.5)  // Darker shadow for dark mode
                  : Colors.black.withOpacity(0.2),  // Lighter shadow for light mode
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // Consistent shadow direction
            ),
          ],
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.button?.copyWith(
                color: Colors.white,  // Override to white text for contrast
                fontWeight: FontWeight.w500,
              ), // Adapt to theme's button text style
        ),
      ),
    );
  }
}
