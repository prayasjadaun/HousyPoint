// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:housy_point/main.dart' as app; // Import your app's main.dart

// void main() {
//   IntegrationTestWidgetsFlutterBinding
//       .ensureInitialized(); // Initialize integration test binding

//   group('HomeScreen UI Tests', () {
//     testWidgets('AppBar logo is displayed', (tester) async {
//       app.main(); // Launch your app
//       await tester.pumpAndSettle(); // Wait for animations

//       final appBarLogoFinder = find.byKey(Key('AppBarLogo'));
//       expect(appBarLogoFinder, findsOneWidget);
//     });

//     testWidgets('Bottom navigation bar exists', (tester) async {
//       app.main(); // Launch your app
//       await tester.pumpAndSettle(); // Wait for animations

//       final bottomNavBarFinder = find.byKey(Key('BottomNavBar'));
//       expect(bottomNavBarFinder, findsOneWidget);
//     });
//   });

//   group('ApartmentListingScreen Tests', () {
//     testWidgets('Displays apartment details correctly', (tester) async {
//       app.main();
//       await tester.pumpAndSettle();

//       // Navigate to ApartmentListingScreen (you'll need to implement this navigation)
//       // For example:
//       // await tester.tap(find.byKey(Key('apartment_card')));
//       await tester.pumpAndSettle();

//       // Verify main elements are present
//       expect(find.text('Apartment'), findsOneWidget);
//       expect(find.text('Woodland Apartments'), findsOneWidget);
//       expect(find.text('Book Now'), findsOneWidget);

//       // Test tab switching
//       await tester.tap(find.text('Gallery'));
//       await tester.pumpAndSettle();
//       expect(find.text('Gallery'), findsOneWidget);

//       await tester.tap(find.text('Review'));
//       await tester.pumpAndSettle();
//       expect(find.text('Review'), findsOneWidget);
//     });

//     testWidgets('Navigation buttons work correctly', (tester) async {
//       app.main();
//       await tester.pumpAndSettle();

//       // Test back button
//       await tester.tap(find.byIcon(Icons.arrow_back));
//       await tester.pumpAndSettle();

//       // Test share and favorite buttons
//       expect(find.byIcon(Icons.share), findsOneWidget);
//       expect(find.byIcon(Icons.favorite_border), findsOneWidget);
//     });
//   });
// }

// class IntegrationTestWidgetsFlutterBinding {
//   static void ensureInitialized() {}
// }
