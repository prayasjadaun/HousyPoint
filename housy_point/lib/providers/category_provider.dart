import 'package:flutter/material.dart';
import 'package:housy_point/models/category_model.dart';

class CategoryProvider with ChangeNotifier {
  final List<Category> _categories = [
    Category(name: "Villa", icon: Icons.home),
    Category(name: "Hotel", icon: Icons.hotel),
    Category(name: "Apartment", icon: Icons.apartment),
    Category(name: "Guesthouse", icon: Icons.villa),
    Category(name: "Voucher", icon: Icons.card_giftcard),
    Category(name: "BIG DEAL", icon: Icons.local_offer),
    Category(name: "To Do", icon: Icons.check_circle),
    Category(name: "See More", icon: Icons.more_horiz),
  ];

  List<Category> get categories => _categories;

  void addCategory(Category category) {
    _categories.add(category);
    notifyListeners();
  }
}
