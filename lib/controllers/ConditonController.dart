import 'package:get/get.dart';

class ConditionsController extends GetxController {
  // Observable list of selected states
  var selectedStates = List<bool>.generate(3, (index) => false).obs;
  // Observable list of selected items
  var selectedItems = <String>[].obs;
  final List<String> list = ["No Smoking", "No Extra Guest", "No Party"];

  // Method to toggle selection
  void toggleSelection(int index) {
    if (selectedStates[index]) {
      selectedItems.remove(list[index]);
    } else {
      selectedItems.add(list[index]);
    }
    selectedStates[index] = !selectedStates[index];
  }
}
