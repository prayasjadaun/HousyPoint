import 'package:flutter/material.dart';
import 'package:housy_point/views/screens/menu_screen.dart';
import 'package:housy_point/views/widgets/bottom_navbar.dart';
import 'package:housy_point/views/widgets/property_filter.dart';
import 'porperty_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // int _selectedIndex = 0;

  // void _onItemSelected(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header with Background Image
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Background Image
                Container(
                  width: double.infinity,
                  height: 400, // Adjust height as necessary
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/prop.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Header Content with User Info and Search
                Positioned(
                  top: 45,
                  left: 10,
                  right: 10,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Avatar and Location Info
                            const Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(
                                      'assets/images/girlprofile.jpg'),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hi! User',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Gurugram',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Search and Menu Icons
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      // Add search functionality here
                                    },
                                    icon: const Icon(Icons.search),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  onPressed: () {
                                    _scaffoldKey.currentState?.openEndDrawer();
                                  },
                                  icon: const Icon(Icons.menu),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Categories Section
                // Positioned(
                //   top: 300,
                //   left: 10,
                //   right: 10,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(20),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.black.withOpacity(0.1),
                //           blurRadius: 10,
                //           offset: const Offset(0, 4),
                //         ),
                //       ],
                //     ),
                //     child: GridView.count(
                //       mainAxisSpacing: 8.0,
                //       crossAxisSpacing: 5.0,
                //       crossAxisCount: 4,
                //       shrinkWrap: true,
                //       physics: const NeverScrollableScrollPhysics(),
                //       children: categories
                //           .map((category) => CategoryItem(category: category))
                //           .toList(),
                //     ),
                //   ),
                // ),
                Positioned(
                  top: 250,
                  left: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const PropertyFilters(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 350),
            // Property List Section
            const PropertyListScreen(
              selectedCategory: null,
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: const BottomNavBar(
          // selectedIndex: _selectedIndex,
          // onItemSelected: _onItemSelected,
          ),
    );
  }
}
