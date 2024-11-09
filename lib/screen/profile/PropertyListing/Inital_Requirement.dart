import 'package:comfystay/components/CustomButton.dart';
import 'package:comfystay/controllers/DataController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitialRequirementPage extends StatefulWidget {
  @override
  _InitialRequirementPageState createState() => _InitialRequirementPageState();
}

class _InitialRequirementPageState extends State<InitialRequirementPage> {
  // List of predefined initial requirements
  final List<String> initialRequirements = [
    'Valid Photo ID Required',
    'Proof of Income',
    'Background Check Required',
    'Security Deposit Due Upon Signing',
    'Minimum Lease Term (e.g., 6 months, 1 year)',
    'First Month’s Rent Due Upon Signing',
    'Credit Check Required',
    'References from Previous Landlords',
    'Employment Verification',
    'Co-Signer May Be Required',
    'Renter’s Insurance Required',
    'Non-Refundable Application Fee',
    'Pets Allowed with Deposit',
    'No Previous Evictions',
    'Income to Rent Ratio of 3:1 (or similar)',
    'Applicant Must Be at Least 18 Years Old',
    'Proof of Current Address',
    'No Criminal Record (depending on policy)',
    'Personal or Professional References Required',
    'Tenant Must Agree to HOA (Homeowners Association) Rules, If Applicable',
  ];

  // Set to track selected initial requirements
  Set<String> selectedRequirements = Set<String>();
  final DataController dataController = Get.find();  // Accessing the DataController


  // Function to show an alert dialog for adding a new initial requirement
  void _showAddRequirementDialog() {
    TextEditingController requirementController = TextEditingController();
    

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Add Initial Requirement"),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close),
              )
            ],
          ),
          content: TextField(
            controller: requirementController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter new requirement",
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                if (requirementController.text.isNotEmpty) {
                  setState(() {
                    initialRequirements.add(requirementController.text);
                  });
                  Navigator.of(context).pop();
                }
              },
              child: CustomButton(text: "Add"),
            ),
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
        title: const Text('Initial Requirements'),
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
                children: initialRequirements.map((requirement) {
                  final isSelected = dataController.selectedInitialRequirements
                      .contains(requirement);
                  return ChoiceChip(
                    label: Text(requirement),
                    selected: isSelected,
                    onSelected: (selected) {
                       setState(() {
                        if (selected) {
                          dataController.addInitialRequirement(requirement);
                        } else {
                          dataController.selectedInitialRequirements.remove(requirement);
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
                  // Plus icon for adding more requirements
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.teal,
                    child: IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: _showAddRequirementDialog, // Open alert dialog
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/whatsincluded'); // Navigate to the next page
                },
                child: const CustomButton(text: "Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
