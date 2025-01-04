// lib/widgets/app_drawer.dart
import 'package:flutter/material.dart';
import 'package:housy_point/providers/menu_provider.dart';
import 'package:housy_point/views/widgets/utils/menu_items.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(
      builder: (context, menuProvider, child) {
        return Drawer(
          backgroundColor: Colors.white,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildLoginSection(),
                    const SizedBox(height: 20),
                    _buildMenuItems(context, menuProvider),
                    const SizedBox(height: 20),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade100,
            child: const Text('HP'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Login/Sign-up now',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                ),
                Text(
                  'Login for best deals & offers',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context, MenuProvider menuProvider) {
    return Column(
      children: [
        MenuItem(
          icon: Icons.view_compact_alt,
          title: 'View/Manage Properties',
          subtitle: 'View,and list your property',
          onTap: () {
            Navigator.pop(context);
            // Add navigation logic here
          },
        ),
        const SizedBox(
          height: 8,
        ),
        MenuItem(
          icon: Icons.developer_board_outlined,
          title: 'Developers',
          onTap: () {
            Navigator.pop(context);
            // Add navigation logic here
          },
        ),
        const SizedBox(
          height: 8,
        ),
        MenuItem(
          icon: Icons.list_alt_outlined,
          title: 'Listings',
          trailing: menuProvider.language,
          onTap: () {
            Navigator.pop(context);
            // Add navigation logic here
          },
        ),
        const SizedBox(
          height: 8,
        ),
        MenuItem(
          icon: Icons.currency_rupee,
          title: 'Resale Properties',
          trailing: menuProvider.country,
          onTap: () {
            Navigator.pop(context);
            // Add navigation logic here
          },
        ),
        const SizedBox(
          height: 8,
        ),
        MenuItem(
          icon: Icons.currency_exchange,
          title: 'Rent Properties',
          trailing: menuProvider.currency,
          onTap: () {
            Navigator.pop(context);
            // Add navigation logic here
          },
        ),
        const SizedBox(
          height: 8,
        ),
        MenuItem(
          icon: Icons.home_filled,
          title: 'Commercial Properties',
          onTap: () {
            Navigator.pop(context);
            // Add navigation logic here
          },
        ),
        const SizedBox(
          height: 8,
        ),
        MenuItem(
          icon: Icons.rocket_launch,
          title: 'New Launch',
          onTap: () {
            Navigator.pop(context);
            // Add navigation logic here
          },
        ),
        const SizedBox(
          height: 8,
        ),
        MenuItem(
          icon: Icons.local_atm_rounded,
          title: 'Home Loan',
          onTap: () {
            Navigator.pop(context);
            // Add navigation logic here
          },
        ),
        const SizedBox(
          height: 8,
        ),
        MenuItem(
          icon: Icons.design_services_outlined,
          title: 'Interior Designing',
          onTap: () {
            Navigator.pop(context);
            // Add navigation logic here
          },
        ),
        const SizedBox(
          height: 8,
        ),
        MenuItem(
          icon: Icons.looks,
          title: 'Looking For',
          onTap: () {
            Navigator.pop(context);
            // Add navigation logic here
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(
              onPressed: () {},
              child: Text(
                "Buy",
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.blue.shade900),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            OutlinedButton(
              onPressed: () {},
              child: Text(
                "Sell",
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.blue.shade900),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            OutlinedButton(
              onPressed: () {},
              child: Text(
                "Rent",
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.blue.shade900),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: const Text('User Agreement'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Privacy Policy'),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Terms of Service'),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/google_play_store.png', height: 30),
            const SizedBox(width: 20),
            Image.asset('assets/icons/app_store.png', height: 30),
          ],
        ),
      ],
    );
  }
}
