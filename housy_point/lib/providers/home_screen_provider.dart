import 'package:flutter/foundation.dart';

class HomeScreenProvider with ChangeNotifier {
  // Selected Category
  Category? _selectedCategory;

  Category? get selectedCategory => _selectedCategory;

  void setSelectedCategory(Category category) {
    _selectedCategory = category;
    notifyListeners(); // Notify listeners of the change
  }
}
