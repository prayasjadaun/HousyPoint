import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:housy_point/views/screens/add_property_screen.dart';
import 'package:housy_point/views/screens/menu_screen.dart';
import 'package:housy_point/views/screens/porperty_list_screen.dart';
import 'package:housy_point/views/screens/profile_screen.dart';
import 'package:housy_point/views/screens/search_screen.dart';
import 'package:housy_point/views/screens/shortlisted_screen.dart';
import 'package:housy_point/views/widgets/utils/property_filter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeContent(),
    const SearchScreen(),
    const AddPropertyScreen(),
    const ShortlistedScreen(),
    const ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF004240),
        title: Image.asset(
          'assets/applogos/logo.png',
          height: 50,
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                // Add search functionality here
              },
              icon: const Icon(Icons.search, color: Colors.white),
            ),
          ),
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ],
      ),
      key: _scaffoldKey,
      endDrawer: const MenuScreen(),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: ConvexAppBar(
        height: 50,
        style: TabStyle.reactCircle, // Style for animation effects
        backgroundColor: Color(0xFF004240),
        activeColor: Colors.white,
        color: Colors.grey.shade300,
        initialActiveIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          TabItem(
            icon: Icons.home,
            title: 'Home',
          ),
          TabItem(icon: Icons.search, title: 'Search'),
          TabItem(icon: Icons.add, title: 'Rent/Sell'),
          TabItem(icon: Icons.favorite, title: 'Shortlisted'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  HomeContent({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        endDrawer: const MenuScreen(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
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
                            height: 500,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/propertyone.jpeg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Gradient Overlay with opacity at the bottom
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(
                                          0.9), // Adjust opacity here
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Header Content
                          // Positioned(
                          //   top: 45,
                          //   left: 10,
                          //   right: 10,
                          //   child: Column(
                          //     children: [
                          //       Container(
                          //         padding: const EdgeInsets.all(10.0),
                          //         height: 70,
                          //         decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.circular(15.0),
                          //         ),
                          //         child: Row(
                          //           mainAxisAlignment:
                          //               MainAxisAlignment.spaceBetween,
                          //           children: [
                          //             // Avatar and Location Info
                          //             const Row(
                          //               children: [
                          //                 CircleAvatar(
                          //                   radius: 30,
                          //                   backgroundImage: AssetImage(
                          //                       'assets/images/girlprofile.jpg'),
                          //                 ),
                          //                 SizedBox(width: 10),
                          //                 Column(
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   children: [
                          //                     Text(
                          //                       'Hi! User',
                          //                       style: TextStyle(
                          //                         fontWeight: FontWeight.w600,
                          //                       ),
                          //                     ),
                          //                     Text(
                          //                       'Gurugram',
                          //                       style: TextStyle(
                          //                         fontWeight: FontWeight.w600,
                          //                         color: Colors.grey,
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ],
                          //             ),
                          //             // Search and Menu Icons
                          //             Row(
                          //               children: [
                          //                 Container(
                          //                   decoration: BoxDecoration(
                          //                     border: Border.all(
                          //                         color: Colors.grey),
                          //                     shape: BoxShape.circle,
                          //                   ),
                          //                   child: IconButton(
                          //                     onPressed: () {
                          //                       // Add search functionality here
                          //                     },
                          //                     icon: const Icon(Icons.search),
                          //                   ),
                          //                 ),
                          //                 const SizedBox(width: 10),
                          //                 IconButton(
                          //                   onPressed: () {
                          //                     _scaffoldKey.currentState
                          //                         ?.openEndDrawer();
                          //                   },
                          //                   icon: const Icon(Icons.menu),
                          //                 ),
                          //               ],
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          Positioned(
                            top: 300,
                            left: 10,
                            right: 10,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10),
                              decoration: BoxDecoration(
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
                      const SizedBox(height: 300),
                      // Property List Section
                      const PropertyListScreen(
                        selectedCategory: 'All',
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
