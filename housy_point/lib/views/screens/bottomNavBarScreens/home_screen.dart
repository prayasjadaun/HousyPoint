import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:housy_point/views/screens/bottomNavBarScreens/search_header_screen.dart';
import 'package:housy_point/views/screens/homeContentScreen/distress_deal_screen.dart';
import 'package:housy_point/views/screens/homeContentScreen/popular_places.dart';
import 'package:housy_point/views/screens/homeContentScreen/menu_screen.dart';
import 'package:housy_point/views/screens/bottomNavBarScreens/notifications_screen.dart';
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
    _tabController = TabController(length: 5, vsync: this);
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
      endDrawer: const MenuScreen(),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const TabContent(child: HomeContent()),
          const TabContent(child: ShortlistedScreen()),
          const TabContent(child: AddPropertyScreen()),
          const TabContent(child: NotificationsScreen()),
          TabContent(child: ProfileScreen()),
        ],
      ),
      bottomNavigationBar: Consumer<ShortlistProvider>(
        builder: (context, shortlistProvider, child) {
          return ConvexAppBar(
            height: 50,
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
              TabItem(icon: Icons.notifications, title: 'Notification'),
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

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    final Map<String, List<String>> locationProperties = {
      "Jammu & Kashmir": ["Property 1", "Property 2", "Property 3"],
      "Himachal Pradesh": ["Property 4", "Property 5"],
      "Punjab": ["Property 6", "Property 7"],
      "Haryana": ["Property 8", "Property 9"],
      "Uttarakhand": ["Property 10"],
      "Uttar Pradesh": ["Property 11", "Property 12"],
    };

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
                          right: 80,
                          child: GestureDetector(
                            onTap: () {
                              showSearchHeaderDialog(
                                context,
                                locationProperties,
                                (query) {
                                  print('User searched for: $query');
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              height: 60,
                              decoration: BoxDecoration(
                                color: backgroundColor,
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
                                  Icon(Icons.search, size: 28),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Search for homes, aparts etc.',
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 50,
                          right: 20,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.filter_list_sharp,
                                      color: Colors.black),
                                  onPressed: () {
                                    Scaffold.of(context).openEndDrawer();
                                  },
                                ),
                              ],
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
