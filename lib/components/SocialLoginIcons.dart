import 'package:flutter/material.dart';

class SocialLoginIcons extends StatelessWidget {
  const SocialLoginIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset('assets/images/google.png', width: 24, height: 24),
        const Icon(Icons.facebook, color: Colors.blue, size: 32),
      ],
    );
  }
}
