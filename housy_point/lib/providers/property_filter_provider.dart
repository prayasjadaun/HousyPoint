// import 'package:flutter/material.dart';

// class PropertyFiltersProvider with ChangeNotifier {
//   int selectedLocationIndex = 0;
//   List<String> locations = ['Location1', 'Location2', 'Location3'];
//   String selectedDeveloper = 'Developer1';
//   List<String> developers = ['Developer1', 'Developer2', 'Developer3'];

//   List<String> propertyTypes = ['Type1', 'Type2', 'Type3'];
//   int selectedPropertyTypeIndex = 0;

//   List<Map<String, String>> bhkTypes = [
//     {'type': '1 BHK'},
//     {'type': '2 BHK'},
//     {'type': '3 BHK'},
//   ];
//   int selectedBHKIndex = 0;

//   bool isDistressDealsExpanded = false;
//   int selectedDealTypeIndex = 0;

//   void updateLocation(int index) {
//     selectedLocationIndex = index;
//     notifyListeners();
//   }

//   void updateDeveloper(String developer) {
//     selectedDeveloper = developer;
//     notifyListeners();
//   }

//   void updatePropertyType(int index) {
//     selectedPropertyTypeIndex = index;
//     notifyListeners();
//   }

//   void updateBHK(int index) {
//     selectedBHKIndex = index;
//     notifyListeners();
//   }

//   void toggleDistressDeals() {
//     isDistressDealsExpanded = !isDistressDealsExpanded;
//     notifyListeners();
//   }

//   void updateDealType(int index) {
//     selectedDealTypeIndex = index;
//     notifyListeners();
//   }
// }
