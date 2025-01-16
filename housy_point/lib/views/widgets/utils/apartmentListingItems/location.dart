// import 'package:flutter/material.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';

// class ApartmentMapScreen extends StatefulWidget {
//   @override
//   _ApartmentMapScreenState createState() => _ApartmentMapScreenState();
// }

// class _ApartmentMapScreenState extends State<ApartmentMapScreen> {
//   late MapboxMapController mapController;

//   final LatLng _initialPosition = LatLng(28.4595, 77.0266);  // Position for the map

//   void _onMapCreated(MapboxMapController controller) {
//     mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return  MapboxMap(
//         styleString: "mapbox://styles/mapbox/streets-v11",  // Use a valid Mapbox style
//         accessToken: "<YOUR_MAPBOX_ACCESS_TOKEN>",         // Replace with your Mapbox access token
//         initialCameraPosition: CameraPosition(
//           target: _initialPosition,
//           zoom: 14.0,
//         ),
//         onMapCreated: _onMapCreated,
      
//     );
//   }
// }
