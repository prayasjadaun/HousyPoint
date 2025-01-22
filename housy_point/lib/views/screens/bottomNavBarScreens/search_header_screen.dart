import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class SearchHeaderDialog extends StatefulWidget {
  final List<String> properties; // List of property names
  final Function(String) onSearch;

  final Map<String, List<String>> locationProperties;
  const SearchHeaderDialog({
    Key? key,
    required this.properties,
    required this.onSearch,
    required this.locationProperties,
  }) : super(key: key);

  @override
  _SearchHeaderDialogState createState() => _SearchHeaderDialogState();
}

class _SearchHeaderDialogState extends State<SearchHeaderDialog> {
  List<String> filteredProperties = [];
  String userLocation = "Fetching Location...";

  @override
  void initState() {
    super.initState();
    filteredProperties = widget.properties; // Initially show all properties
    _getCurrentLocation(); // Fetch location on dialog open
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Prompt the user to enable location services
        setState(() {
          userLocation = "Location services are disabled. Please enable them.";
        });
        return;
      }

      // Check location permission status
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied
          setState(() {
            userLocation = "Location permission denied.";
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are permanently denied
        setState(() {
          userLocation =
              "Location permission permanently denied. Please enable it in settings.";
        });
        return;
      }

      // Fetch the user's current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          userLocation =
              "${place.locality}, ${place.administrativeArea}, ${place.country}";
        });
      } else {
        setState(() {
          userLocation = "Unable to fetch address.";
        });
      }
    } catch (e) {
      // Catch any other unexpected errors
      setState(() {
        userLocation = "Error retrieving location: $e";
      });
    }
  }


  void _filterProperties(String query) {
    final results = widget.properties
        .where(
            (property) => property.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      filteredProperties = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Material(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          elevation: 4,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Search Popular Places',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Your Location: $userLocation',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (query) {
                    widget.onSearch(query);
                    _filterProperties(query);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search home aparts etc...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: filteredProperties.isNotEmpty
                      ? ListView.builder(
                          itemCount: filteredProperties.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const Icon(Icons.location_on),
                              title: Text(filteredProperties[index]),
                              onTap: () {
                                // Handle property selection
                                Navigator.of(context)
                                    .pop(filteredProperties[index]);
                              },
                            );
                          },
                        )
                      : const Center(
                          child: Text('No properties found.'),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showSearchHeaderDialog(BuildContext context,
    Map<String, List<String>> locationProperties, Function(String) onSearch) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Close",
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) {
      return SearchHeaderDialog(
        locationProperties: locationProperties,
        onSearch: onSearch,
        properties: [],
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(anim),
        child: child,
      );
    },
  );
}
