
import 'package:comfystay/components/CustomButton.dart';
import 'package:flutter/material.dart';

class ConditionsScreen extends StatefulWidget {
  @override
  _ConditionsScreenState createState() => _ConditionsScreenState();
}

class _ConditionsScreenState extends State<ConditionsScreen> {
  // Example condition list
  final List<String> conditions = [
    'No Smoking',
    'No Extra Guest',
    'No Party',
    'After 8 PM no entry'
    'No Smokingss',
    'No Extra Guessst',
    'No Partys',
    'After 8 PsM no entry''No Smoking',
    'No Extra Gsuest',
    'No Partsy',
    'Afters 8 PsM no entry'
    'ss'
    'After'
  ];

  // Keeping track of selected conditions
  Set<String> selectedConditions = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text('Conditions'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Padding(
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
            const Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: [
                // Duplicate conditions as per your image layout
                
                // Plus icon for adding more conditions
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
            const CustomButton(text: "Next")
          ],
        ),
      ),
    );
  }
}