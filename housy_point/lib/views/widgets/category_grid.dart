import 'package:flutter/material.dart';
import 'package:housy_point/views/widgets/catogery_item.dart';
import '../../models/category_model.dart';

class CategoryGrid extends StatelessWidget {
  final List<Category> categories;

  const CategoryGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: categories
          .map((category) => CategoryItem(category: category))
          .toList(),
    );
  }
}
