import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  image: DecorationImage(
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
                    CircleAvatar(
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
                        backgroundColor: Colors.green.shade900,
                        child: Icon(
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
          SizedBox(height: 60),
          // Options List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ProfileOption(
                  icon: Icons.developer_board_outlined,
                  title: 'Developers',
                  onTap: () {},
                ),
                ProfileOption(
                  icon: Icons.list_alt_outlined,
                  title: 'Listings',
                  onTap: () {},
                ),
                ProfileOption(
                  icon: Icons.currency_rupee,
                  title: 'Resale Properties',
                  onTap: () {},
                ),
                ProfileOption(
                  icon: Icons.currency_exchange,
                  title: 'Rent Properties',
                  onTap: () {},
                ),
                ProfileOption(
                  icon: Icons.home_filled,
                  title: 'Commercial Properties',
                  onTap: () {},
                ),
                ProfileOption(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {},
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

  const ProfileOption({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade200,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.green.shade900),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
