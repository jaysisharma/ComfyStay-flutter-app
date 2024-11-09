import 'package:comfystay/components/CustomButton.dart';
import 'package:comfystay/controllers/DataController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConditionsScreen extends StatefulWidget {
  @override
  _ConditionsScreenState createState() => _ConditionsScreenState();
}

class _ConditionsScreenState extends State<ConditionsScreen> {
  final DataController dataController = Get.find();
  
  // Example list of conditions
 final List<String> conditions = [
  'No Smoking',
  'No Pets Allowed',
  'No Extra Guests',
  'No Parties or Events',
  'Quiet Hours After 10 PM',
  'Guest Registration Required',
  'No Subletting',
  'Non-refundable Security Deposit',
  'Check-in After 3 PM, Check-out Before 11 AM',
  'Proper Use of Appliances',
  'No Alterations to the Property',
  'Maintain Cleanliness',
  'No Loud Noise or Disturbance',
  'Compliance with Local Laws',
  'Valid ID Required at Check-in',
  'No Unregistered Vehicles',
  'Respect Neighbor’s Privacy',
  'No Illegal Activities',
  'Do Not Block Driveways',
  'Keep the Door Locked When Not Home'
];


  // Function to show a dialog for adding a new condition
  void _showAddConditionDialog() {
    TextEditingController conditionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Add Condition"),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close)
              ),
            ],
          ),
          content: TextField(
            controller: conditionController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter new condition",
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                if (conditionController.text.isNotEmpty) {
                  setState(() {
                    conditions.add(conditionController.text); // Add to local list
                  });
                  Navigator.of(context).pop();
                }
              },
              child: CustomButton(text: "Add")
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: const Text('Conditions'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: conditions.map((condition) {
                  final isSelected = dataController.selectedConditions.contains(condition);
                  return ChoiceChip(
                    label: Text(condition),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          dataController.addCondition(condition);
                        } else {
                          dataController.selectedConditions.remove(condition);
                        }
                      });
                    },
                    selectedColor: Colors.teal,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20.0),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: [
                  // Plus icon for adding more conditions
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.teal,
                    child: IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: _showAddConditionDialog, // Open alert dialog
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/requirements'); // Navigate to next screen
                },
                child: CustomButton(text: "Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
