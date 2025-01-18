import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class InteractiveMapScreen extends StatefulWidget {
  const InteractiveMapScreen({Key? key}) : super(key: key);

  @override
  State<InteractiveMapScreen> createState() => _InteractiveMapScreenState();
}

class _InteractiveMapScreenState extends State<InteractiveMapScreen> {
  final MapController _mapController = MapController();
  LatLng _currentLocation = LatLng(28.4595, 77.0266); // Gurugram, India
  final List<Marker> _markers = [];
  bool _isLoading = false;

  Future<void> _fetchCoordinates(String placeName) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final url = Uri.parse(
          'https://nominatim.openstreetmap.org/search?q=$placeName&format=json&limit=1');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;

        if (data.isNotEmpty) {
          final lat = double.parse(data[0]['lat']);
          final lon = double.parse(data[0]['lon']);
          final newLocation = LatLng(lat, lon);

          setState(() {
            // Clear previous markers
            _markers.clear();

            // Add new marker
            _currentLocation = newLocation;
            _markers.add(
              Marker(
                width: 80.0,
                height: 80.0,
                point: newLocation,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40.0,
                ),
              ),
            );
          });

          _mapController.move(newLocation, 13.0);
        } else {
          _showErrorSnackbar('No results found for "$placeName"');
        }
      } else {
        _showErrorSnackbar('Error fetching data from server');
      }
    } catch (e) {
      _showErrorSnackbar('An error occurred: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _currentLocation,
            initialZoom: 13.0,
            onTap: (tapPosition, point) {
              setState(() {
                _markers.add(
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: point,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40.0,
                    ),
                  ),
                );
              });
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'http://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
            MarkerLayer(
              markers: _markers,
            ),
          ],
        ),
        Positioned(
          top: 10,
          left: 10,
          right: 10,
          child: Card(
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter place name',
                      contentPadding: EdgeInsets.all(16),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search,
                          color: Colors.black.withOpacity(0.7)),
                    ),
                    style: TextStyle(color: Colors.black.withOpacity(0.7)),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        _fetchCoordinates(value);
                      }
                    },
                  ),
                ),
                if (_isLoading)
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: () {
              _mapController.move(_currentLocation, 13.0);
            },
            backgroundColor: Colors.blueAccent,
            child: const Icon(Icons.my_location),
          ),
        ),
      ],
    );
  }
}
