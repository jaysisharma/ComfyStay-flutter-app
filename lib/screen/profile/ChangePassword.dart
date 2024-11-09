// import 'package:comfystay/components/CustomButton.dart';
// import 'package:comfystay/components/CustomTextField.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class changePassword extends StatelessWidget {
//   const changePassword({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         foregroundColor: Colors.white,
//         title: Text(
//           "Change Password",
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 18.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
            
//             CustomTextField(label: "Old Password", icon: Icons.lock, hint: ""),
//             SizedBox(height: 10),
//             CustomTextField(label: "New Password", icon: Icons.lock, hint: ""),
//             SizedBox(height: 10),
//             CustomTextField(
//                 label: "Confirm Password", icon: Icons.lock, hint: ""),
//             SizedBox(height: 10),
//             CustomButton(text: "Submit")
//           ],
//         ),
//       ),
//     );
//   }
// }
