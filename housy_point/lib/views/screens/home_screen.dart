import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:housy_point/views/screens/add_property_screen.dart';
import 'package:housy_point/views/screens/loan_screen.dart';
import 'package:housy_point/views/screens/menu_screen.dart';
import 'package:housy_point/views/screens/porperty_list_screen.dart';
import 'package:housy_point/views/screens/profile_screen.dart';
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
    const AddPropertyScreen(key: Key('AddPropertyScreen')),
    const ShortlistedScreen(key: Key('ShortlistedScreen')),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF004240),
        title: Image.asset(
          'assets/applogos/logo.png',
          key: const Key('AppBarLogo'),
          height: 50,
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              key: const Key('SearchIcon'),
              onPressed: () {
                debugPrint('Search button pressed'); // Mock search action
              },
              icon: const Icon(Icons.search, color: Colors.white),
            ),
          ),
          IconButton(
            key: const Key('MenuIcon'),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: const Icon(Icons.menu, color: Colors.white),
          ),
        ],
      ),
      key: _scaffoldKey,
      endDrawer: const MenuScreen(),
      body: PageView(
        key: const Key('PageView'),
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: ConvexAppBar(
        key: const Key('BottomNavBar'),
        height: 50,
        style: TabStyle.reactCircle,
        backgroundColor: const Color(0xFF004240),
        activeColor: Colors.white,
        color: Colors.grey.shade300,
        initialActiveIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
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
            key: const Key('HomeContentScroll'),
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
                          key: const Key('BackgroundImage'),
                          width: double.infinity,
                          height: 500,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/propertyone.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Gradient Overlay
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.9),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Filters
                        Positioned(
                          top: 300,
                          left: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
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
                      key: Key('PropertyListScreen'),
                      selectedCategory: 'India',
                    ),
                    const SizedBox(height: 20),

                    SectionTitle(title: 'Popular Place'),
                    SizedBox(height: 8),
                    HorizontalListView(),
                    SizedBox(height: 16),
                    // SectionTitle(title: 'Nearby You'),
                    // SizedBox(height: 8),
                    // HorizontalListView(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
