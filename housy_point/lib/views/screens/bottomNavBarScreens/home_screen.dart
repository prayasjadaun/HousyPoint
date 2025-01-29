import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:housy_point/views/screens/homeContentScreen/search_header_screen.dart';
import 'package:housy_point/views/screens/homeContentScreen/distress_deal_screen.dart';
import 'package:housy_point/views/screens/homeContentScreen/location_search.dart';
import 'package:housy_point/views/screens/homeContentScreen/popular_places.dart';
import 'package:housy_point/views/screens/homeContentScreen/menu_screen.dart';
import 'package:housy_point/views/screens/homeContentScreen/distress_deal_property_screen_screen.dart';
import 'package:provider/provider.dart';
import 'package:housy_point/views/screens/bottomNavBarScreens/add_property_screen.dart';
import 'package:housy_point/views/screens/bottomNavBarScreens/shortlisted_screen.dart';
import 'package:housy_point/views/screens/bottomNavBarScreens/profile_screen.dart';
import 'package:housy_point/controllers/providers/shortlisted_provider.dart';
import 'package:housy_point/views/widgets/utils/uspFilterCard/usp_property_filter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _preloadExpensiveWidgets();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    _tabController.animateTo(index);
  }

  void _preloadExpensiveWidgets() {
    Future.microtask(() {
      DistressDealPropertyScreen();
      HorizontalListView();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Detect system theme using MediaQuery
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final activeColor = isDarkMode ? Colors.white : Colors.black;
    final iconColor = isDarkMode ? Colors.grey : Colors.grey.shade600;

    return Scaffold(
      key: _scaffoldKey,
      // endDrawer: const MenuScreen(),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const TabContent(child: HomeContent()),
          const TabContent(child: ShortlistedScreen()),
          const TabContent(child: AddPropertyScreen()),
          TabContent(child: ProfileScreen()),
        ],
      ),
      bottomNavigationBar: Consumer<ShortlistProvider>(
        builder: (context, shortlistProvider, child) {
          return ConvexAppBar(
            height: 60,
            style: TabStyle.reactCircle,
            backgroundColor: backgroundColor,
            activeColor: activeColor,
            color: iconColor,
            initialActiveIndex: _currentIndex,
            onTap: _onTabTapped,
            items: const [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.favorite, title: 'Shortlisted'),
              TabItem(icon: Icons.add, title: 'Rent/Sell'),
              TabItem(icon: Icons.person, title: 'Profile'),
            ],
          );
        },
      ),
    );
  }
}

class TabContent extends StatefulWidget {
  final Widget child;

  const TabContent({Key? key, required this.child}) : super(key: key);

  @override
  State<TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<TabContent>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}

// Home Screen Content
class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final List<String> propertyTypes = ["'Apartment'", "'Home'", "'Villa'"];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTextAnimation();
  }

  void _startTextAnimation() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _currentIndex = (_currentIndex + 1) % propertyTypes.length;
      });
      _startTextAnimation();
    });
  }

  List<String> properties = [
    "DLF Cyber City, Gurgaon",
    "Powai, Mumbai",
    "Whitefield, Bangalore",
    "Salt Lake City, Kolkata",
    // "Connaught Place, Delhi",
    // "Indiranagar, Bangalore",
    // "Gachibowli, Hyderabad",
    // "Banjara Hills, Hyderabad",
    // "Koramangala, Bangalore",
    // "Sector 62, Noida",
    // "Hinjewadi, Pune",
    // "Anna Nagar, Chennai",
  ];
  List<String> projects = [
    "HCBS Sports Villa, Sohna",
    "4 & 5, Sohna",
    "Powai, Mumbai",
  ];
  List<String> builders = [
    "Signature Global",
    "Powai, Mumbai",
  ];
  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      endDrawer: const MenuScreen(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            key: const Key('HomeContentScroll'),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 450,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/propertyfour.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            height: 400,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.3),
                                  Colors.black.withOpacity(0.9),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 50,
                          left: 20,
                          right: 20,
                          child: GestureDetector(
                            onTap: () {
                              showSearchHeaderDialog(
                                context,
                                properties, // Pass your dynamic list of properties here
                                projects, // Pass your dynamic list of projects here
                                builders, // Pass your dynamic list of builders here
                                (query) {
                                  print('User searched for: $query');
                                  // You can add your custom search handling logic here
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: AnimatedSwitcher(
                                      duration: const Duration(
                                          seconds:
                                              2), // Shortened duration for a quicker transition
                                      switchInCurve: Curves
                                          .easeInOut, // Smooth in and out transition
                                      switchOutCurve: Curves
                                          .easeOut, // Smooth transition when switching out
                                      child: Row(
                                        key: ValueKey<int>(
                                            _currentIndex), // Key for identifying and animating the changes
                                        children: [
                                          Text(
                                            "Search for ",
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            propertyTypes[_currentIndex],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.search,
                                    size: 28,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.person,
                                              color: Colors.black),
                                          onPressed: () {
                                            Scaffold.of(context)
                                                .openEndDrawer();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 265,
                          right: 10,
                          left: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            height: 60,
                            decoration: BoxDecoration(
                                color: Color(0xFF004240).withOpacity(0.7),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Are you a Property Owner? ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  'Sell/Rent for FREE ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                        const Positioned(
                          top: 300,
                          left: 10,
                          right: 10,
                          child: UspPropertyFilter(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 290),
                    Center(child: DistressDealsWidget()),
                    DistressDealPropertyScreen(),
                    const SizedBox(height: 20),
                    // s
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
