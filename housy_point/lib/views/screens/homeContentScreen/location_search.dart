// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

// class LocationWidget extends StatefulWidget {
//   @override
//   _LocationWidgetState createState() => _LocationWidgetState();
// }

// class _LocationWidgetState extends State<LocationWidget> {
//   String userLocation = "Fetching Location...";

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation(); // Fetch location on widget initialization
//   }

//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     try {
//       // Check if location services are enabled
//       serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         setState(() {
//           userLocation = "Location services are disabled. Please enable them.";
//         });
//         return;
//       }

//       // Check location permission status
//       permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           setState(() {
//             userLocation = "Location permission denied.";
//           });
//           return;
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         setState(() {
//           userLocation = "Location permission permanently denied. Please enable it in settings.";
//         });
//         return;
//       }

//       // Fetch the user's current position
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);

//       List<Placemark> placemarks = await placemarkFromCoordinates(
//           position.latitude, position.longitude);

//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks.first;
//         setState(() {
//           userLocation =
//               "${place.locality}, ${place.administrativeArea}, ${place.country}";
//         });
//       } else {
//         setState(() {
//           userLocation = "Unable to fetch address.";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         userLocation = "Error retrieving location: $e";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       top: 40,
//       left: 5,
//       right: 5,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: Colors.transparent,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.location_on),
//                     Text(userLocation), // Display the fetched location
//                   ],
//                 ),
//               ],
//             ),
//             Container(
//               height: 40,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//               ),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.person, color: Colors.black),
//                     onPressed: () {
//                       Scaffold.of(context).openEndDrawer();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
