import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:housy_point/views/screens/bottomNavBarScreens/add_property_screen.dart';
import 'package:housy_point/views/screens/homeContentScreen/distress_deal_property_screen_screen.dart';
import 'package:housy_point/views/screens/homeContentScreen/menu_screen.dart';
import 'package:housy_point/views/screens/bottomNavBarScreens/profile_screen.dart';
import 'package:housy_point/views/screens/bottomNavBarScreens/search_header_screen.dart';
import 'package:housy_point/views/widgets/utils/uspFilterCard/usp_property_filter.dart';
import 'package:housy_point/views/screens/bottomNavBarScreens/home_screen.dart';

void main() {
  group('HomeScreen UI Tests', () {
    testWidgets('AppBar logo is displayed', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      await tester.pump(const Duration(seconds: 3)); // Delay added

      final appBarLogoFinder = find.byKey(const Key('AppBarLogo'));
      expect(appBarLogoFinder, findsOneWidget);
    });

    testWidgets('Bottom navigation bar exists', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      await tester.pump(const Duration(seconds: 3)); // Delay added

      final bottomNavBarFinder = find.byKey(const Key('BottomNavBar'));
      expect(bottomNavBarFinder, findsOneWidget);
    });

    testWidgets('Background image is displayed in HomeContent',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      await tester.pump(const Duration(seconds: 3)); // Delay added

      final backgroundImageFinder = find.byKey(const Key('BackgroundImage'));
      expect(backgroundImageFinder, findsOneWidget);
    });
  });

  group('HomeScreen Navigation Tests', () {
    testWidgets('PageView switches screens on tab tap',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      await tester.pump(const Duration(seconds: 3)); // Delay added

      // Tap on the "Search" tab
      final searchTabFinder = find.text('Search');
      await tester.tap(searchTabFinder);
      await tester.pumpAndSettle();

      // Verify SearchScreen is visible
      expect(find.byType(SearchScreen), findsOneWidget);
    });

    testWidgets('Switching to AddPropertyScreen works',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      await tester.pump(const Duration(seconds: 3)); // Delay added

      // Tap on the "Rent/Sell" tab
      final rentSellTabFinder = find.text('Rent/Sell');
      await tester.tap(rentSellTabFinder);
      await tester.pumpAndSettle();

      // Verify AddPropertyScreen is visible
      expect(find.byType(AddPropertyScreen), findsOneWidget);
    });

    testWidgets('Switching to ProfileScreen works',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      await tester.pump(const Duration(seconds: 3)); // Delay added

      // Tap on the "Profile" tab
      final profileTabFinder = find.text('Profile');
      await tester.tap(profileTabFinder);
      await tester.pumpAndSettle();

      // Verify ProfileScreen is visible
      expect(find.byType(ProfileScreen), findsOneWidget);
    });

    testWidgets('Drawer opens when menu icon is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      await tester.pump(const Duration(seconds: 3)); // Delay added

      final menuIconFinder = find.byKey(const Key('MenuIcon'));
      await tester.tap(menuIconFinder);
      await tester.pumpAndSettle();

      expect(find.byType(MenuScreen), findsOneWidget);
    });
  });

  group('Widgets Interaction Tests', () {
    testWidgets('Search icon is tappable', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      await tester.pump(const Duration(seconds: 3)); // Delay added

      final searchIconFinder = find.byKey(const Key('SearchIcon'));
      await tester.tap(searchIconFinder);
      await tester.pump();

      // No action is defined, but ensure it exists and is tappable
      expect(searchIconFinder, findsOneWidget);
    });

    testWidgets('PropertyFilters widget is displayed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      await tester.pump(const Duration(seconds: 3)); // Delay added

      final propertyFiltersFinder = find.byType(PropertyFilters);
      expect(propertyFiltersFinder, findsOneWidget);
    });

    testWidgets('PropertyListScreen displays correct category',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      await tester.pump(const Duration(seconds: 3)); // Delay added

      final propertyListFinder = find.byType(DistressDealPropertyScreen);
      expect(propertyListFinder, findsOneWidget);
    });
  });
}
