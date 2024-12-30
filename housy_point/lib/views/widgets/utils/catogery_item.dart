import 'package:flutter/material.dart';
import '../../../models/category_model.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey.shade300,
          child: Icon(
            category.icon,
            color: Colors.black,
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Text(
            softWrap: true,
            category.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
