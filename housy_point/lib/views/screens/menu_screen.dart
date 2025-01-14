import 'package:flutter/material.dart';
import 'package:housy_point/controllers/providers/menu_provider.dart';
import 'package:housy_point/views/widgets/utils/menu_items.dart';
import 'package:provider/provider.dart';

import '../../controllers/providers/auth_screen_provider.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Accessing the theme

    return Consumer<MenuProvider>(
      builder: (_, menuProvider, child) {
        final authProvider = Provider.of<AuthScreenProvider>(context);
        final backgroundColor =
            theme.brightness == Brightness.dark ? Colors.black : Colors.white;
        final textColor =
            theme.brightness == Brightness.dark ? Colors.white : Colors.black;
        final buttonColor = theme.brightness == Brightness.dark
            ? Colors.blue.shade300
            : Colors.blue.shade900;

        return Drawer(
          backgroundColor:
              backgroundColor, // Set background color based on theme
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildLoginSection(
                        context, authProvider, textColor, buttonColor, theme),
                    const SizedBox(height: 20),
                    _buildMenuItems(context, menuProvider, textColor),
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

  Widget _buildLoginSection(
      BuildContext context,
      AuthScreenProvider authProvider,
      Color textColor,
      Color buttonColor,
      dynamic theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? Colors.blueGrey.shade800
            : Colors.blue.shade200,
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
            backgroundColor: theme.brightness == Brightness.dark
                ? Colors.green.shade200
                : Colors.green.shade100,
            child: const Text('HP'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  authProvider.isAuthenticated
                      ? 'Hello, ${authProvider.userRole}'
                      : 'Login/Sign-up now',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.grey
                            .shade800, // Adjust the color for dark and light mode
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  authProvider.isAuthenticated
                      ? 'Welcome back!'
                      : 'Login for best deals & offers',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade400
                        : Colors.grey
                            .shade800, // Adjust the color for dark and light mode
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              authProvider.isAuthenticated
                  ? Icons.exit_to_app
                  : Icons.chevron_right,
              color: buttonColor, // Dynamic button color
            ),
            onPressed: () {
              if (authProvider.isAuthenticated) {
                authProvider.logout();
              } else {
                Navigator.pushNamed(context, '/login');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(
      BuildContext context, MenuProvider menuProvider, Color textColor) {
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
          textColor: textColor, // Passing dynamic text color
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
          textColor: textColor,
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
          textColor: textColor,
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
          textColor: textColor,
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
          textColor: textColor,
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
          textColor: textColor,
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
          textColor: textColor,
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
          textColor: textColor,
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
          textColor: textColor,
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
          textColor: textColor,
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
                style: TextStyle(fontWeight: FontWeight.w500, color: textColor),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            OutlinedButton(
              onPressed: () {},
              child: Text(
                "Sell",
                style: TextStyle(fontWeight: FontWeight.w500, color: textColor),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            OutlinedButton(
              onPressed: () {},
              child: Text(
                "Rent",
                style: TextStyle(fontWeight: FontWeight.w500, color: textColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Divider(
          height: 10,
          endIndent: 10,
          indent: 10,
          color: Colors.grey,
        ),
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
      ],
    );
  }
}
