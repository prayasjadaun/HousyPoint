import 'package:flutter/material.dart';
import 'package:housy_point/controllers/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context);
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Dynamic colors based on theme
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final cardColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200;
    final iconColor = isDarkMode ? Colors.white : Colors.green.shade900;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          // Top Section with Background Image and Profile Picture
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/propertyone.jpeg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: -50,
                left: MediaQuery.of(context).size.width / 2 - 50,
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        'assets/images/boyProfile.png',
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: iconColor,
                        child: const Icon(
                          Icons.edit,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),
          // Options List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ProfileOption(
                  icon: Icons.developer_board_outlined,
                  title: 'Developers',
                  onTap: () {},
                  cardColor: cardColor,
                  textColor: textColor,
                  iconColor: iconColor,
                ),
                ProfileOption(
                  icon: Icons.list_alt_outlined,
                  title: 'Listings',
                  onTap: () {},
                  cardColor: cardColor,
                  textColor: textColor,
                  iconColor: iconColor,
                ),
                ProfileOption(
                  icon: Icons.currency_rupee,
                  title: 'Resale Properties',
                  onTap: () {},
                  cardColor: cardColor,
                  textColor: textColor,
                  iconColor: iconColor,
                ),
                ProfileOption(
                  icon: Icons.currency_exchange,
                  title: 'Rent Properties',
                  onTap: () {},
                  cardColor: cardColor,
                  textColor: textColor,
                  iconColor: iconColor,
                ),
                ProfileOption(
                  icon: Icons.home_filled,
                  title: 'Commercial Properties',
                  onTap: () {},
                  cardColor: cardColor,
                  textColor: textColor,
                  iconColor: iconColor,
                ),
                ProfileOption(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {},
                  cardColor: cardColor,
                  textColor: textColor,
                  iconColor: iconColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color cardColor;
  final Color textColor;
  final Color iconColor;

  const ProfileOption({
    required this.icon,
    required this.title,
    required this.onTap,
    required this.cardColor,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title, style: TextStyle(color: textColor)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: textColor),
        onTap: onTap,
      ),
    );
  }
}
