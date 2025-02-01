import 'package:flutter/material.dart';
import 'package:housy_point/controllers/providers/propertiesProvider/distress_deal_provider.dart';
import 'package:provider/provider.dart';

/// Widget for Tab UI
class DistressDealsWidget extends StatelessWidget {
  final List<String> tabs = ["RESALE", "RENTING", "COMMERCIAL"];

  @override
  Widget build(BuildContext context) {
    final distressDealProvider = Provider.of<DistressDealProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        const Text(
          "DISTRESS DEALS",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 2,
          width: 80,
          color: Colors.amber,
        ),
        const SizedBox(height: 20),
        Container(
          margin: EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(tabs.length, (index) {
              final bool isSelected =
                  distressDealProvider.selectedIndex == index;
              return GestureDetector(
                onTap: () {
                  distressDealProvider.changeTab(index);
                },
                child: AnimatedContainer(
                  curve: Curves.linearToEaseOut,
                  duration: const Duration(milliseconds: 400),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xFF004240) : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight:
                          isSelected ? FontWeight.w800 : FontWeight.w700,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
