import 'package:comfystay/components/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class WharsIncluded extends StatefulWidget {
  @override
  _WharsIncludedState createState() => _WharsIncludedState();
}

class _WharsIncludedState extends State<WharsIncluded> {
  // Example condition list
  final List<String> conditions = [
    'No Smoking',
    'No Extra Guest',
    'No Party',
    'After 8 PM no entry',
    'No Smokingss',
    'No Extra Guessst',
    'No Partys',
    'After 8 PsM no entry',
    'No Smoking',
    'No Extra Gsuest',
    'No Partsy',
    'Afters 8 PsM no entry',
    'ss',
    'After'
  ];

  // Keeping track of selected conditions
  Set<String> selectedConditions = Set<String>();

  // Function to show an alert dialog for adding a new condition
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
                  icon: Icon(Icons.close))
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
                      conditions.add(conditionController.text);
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: CustomButton(text: "Add"))
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
        title: const Text('Whats Included'),
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
                  final isSelected = selectedConditions.contains(condition);
                  return ChoiceChip(
                    label: Text(condition),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedConditions.add(condition);
                        } else {
                          selectedConditions.remove(condition);
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
              // const CustomButton(text: "Next"),
              GestureDetector(
                  onTap: () {
                    Get.toNamed('/addphotos');
                  },
                  child: const CustomButton(text: "Next")),
            ],
          ),
        ),
      ),
    );
  }
}
