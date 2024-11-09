import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  const DividerWithText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: Colors.grey, thickness: 1, indent: 20, endIndent: 20),
        ),
        const Text("OR", style: TextStyle(fontWeight: FontWeight.bold)),
        const Expanded(
          child: Divider(color: Colors.grey, thickness: 1, indent: 20, endIndent: 20),
        ),
      ],
    );
  }
}
