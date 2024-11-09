import 'package:comfystay/components/CustomButton.dart';
import 'package:comfystay/controllers/DataController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class WhatsIncluded extends StatefulWidget {
  @override
  _WhatsIncludedState createState() => _WhatsIncludedState();
}

class _WhatsIncludedState extends State<WhatsIncluded> {
  final DataController dataController =
      Get.find(); // Accessing the DataController

  // List of items included in the property
  final List<String> includedItems = [
    'Wi-Fi Access',
    'Free Parking',
    'Swimming Pool',
    'Gym Access',
    'Air Conditioning',
    '24/7 Security',
    'Washer and Dryer',
    'Fully Furnished',
    'Cable TV',
    'Cleaning Service',
  ];

  // Keeping track of selected included items
  Set<String> selectedItems = Set<String>();

  // Function to show an alert dialog for adding a new item
  void _showAddItemDialog() {
    TextEditingController itemController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Add Item"),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close),
              ),
            ],
          ),
          content: TextField(
            controller: itemController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter new item",
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                if (itemController.text.isNotEmpty) {
                  setState(() {
                    includedItems.add(itemController.text);
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
        title: const Text('What\'s Included'),
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
                children: includedItems.map((item) {
                  final isSelected =
                      dataController.selectedWhatsIncluded.contains(item);
                  return ChoiceChip(
                    label: Text(item),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          dataController.addWhatsIncluded(item);
                        } else {
                          dataController.selectedWhatsIncluded.remove(item);
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
                  // Plus icon for adding more items
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.teal,
                    child: IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: _showAddItemDialog, // Open alert dialog
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              // Next button to proceed
              GestureDetector(
                onTap: () {
                  Get.toNamed('/addphotos'); // Navigate to the next page
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
