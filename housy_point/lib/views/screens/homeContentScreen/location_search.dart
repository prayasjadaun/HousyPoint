import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:housy_point/views/screens/homeContentScreen/distress_deal_property_screen_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationSearchScreen extends StatefulWidget {
  @override
  _LocationSearchScreenState createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  String userLocation = "Unknown Location";
  List<String> locations = [
    "Jammu & Kashmir",
    "Himachal Pradesh",
    "Punjab",
    "Haryana",
    "Uttarakhand",
    "Uttar Pradesh",
  ];
  List<String> filteredLocations = [];

  @override
  void initState() {
    super.initState();
    filteredLocations = locations;
  }

  Future<void> _getCurrentLocation() async {
    PermissionStatus permission = await Permission.location.request();

    if (permission == PermissionStatus.granted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        setState(() {
          userLocation =
              "Lat: ${position.latitude}, Long: ${position.longitude}";
        });

        // Optionally, convert coordinates to a human-readable address
        // using reverse geocoding with a package like `geocoding`.
      } catch (e) {
        print("Error retrieving location: $e");
        setState(() {
          userLocation = "Unable to retrieve location.";
        });
      }
    } else {
      setState(() {
        userLocation = "Location permission denied.";
      });
    }
  }

  void _filterLocations(String query) {
    setState(() {
      filteredLocations = locations
          .where((location) =>
              location.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _handleLocationSelection(String location) {
    print("Selected Location: $location");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DistressDealPropertyScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Location")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Location: $userLocation",
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: const Text("Enable Location"),
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: _filterLocations,
              decoration: InputDecoration(
                hintText: 'Search for a location...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: filteredLocations.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredLocations.length,
                      itemBuilder: (context, index) {
                        final location = filteredLocations[index];
                        return ListTile(
                          leading: const Icon(Icons.location_on),
                          title: Text(location),
                          onTap: () => _handleLocationSelection(location),
                        );
                      },
                    )
                  : const Center(child: Text("No locations found.")),
            ),
          ],
        ),
      ),
    );
  }
}
