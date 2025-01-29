import 'package:flutter/material.dart';

class PropertySearchTopSheet extends StatefulWidget {
  final VoidCallback onClose;

  PropertySearchTopSheet({required this.onClose});

  @override
  _PropertySearchTopSheetState createState() => _PropertySearchTopSheetState();
}

class _PropertySearchTopSheetState extends State<PropertySearchTopSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<Property> filteredProperties = [];

  @override
  void initState() {
    super.initState();
    filteredProperties = dummyProperties; // Initialize with all properties
  }

  void _searchProperties(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProperties = dummyProperties; // Show all properties if search is empty
      } else {
        filteredProperties = dummyProperties
            .where((property) =>
                property.location.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onClose(); // Close the sheet when tapping outside
      },
      child: Container(
        color: Colors.black.withOpacity(0.5), // Semi-transparent background
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 50), // Adjust margin as needed
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Drag handle
                Container(
                  margin: EdgeInsets.only(top: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Search bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter location...',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          _searchProperties(_searchController.text);
                        },
                      ),
                    ),
                    controller: _searchController,
                    onChanged: (value) {
                      _searchProperties(value); // Search as user types
                    },
                  ),
                ),
                // Display search results
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredProperties.length,
                    itemBuilder: (context, index) {
                      final property = filteredProperties[index];
                      return ListTile(
                        leading: Image.network(
                          property.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(property.name),
                        subtitle: Text(property.location),
                      );
                    },
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


// Dummy Data
class Property {
  final String name;
  final String location;
  final String imageUrl;

  Property(
      {required this.name, required this.location, required this.imageUrl});
}

List<Property> dummyProperties = [
  Property(
    name: 'Modern Apartment',
    location: 'New York',
    imageUrl: 'assets/images/propertyone.jpeg',
  ),
  Property(
    name: 'Cozy Cottage',
    location: 'Los Angeles',
    imageUrl: 'assets/images/propertyone.jpeg',
  ),
  Property(
    name: 'Luxury Villa',
    location: 'Miami',
    imageUrl: 'assets/images/propertyone.jpeg',
  ),
  Property(
    name: 'Rustic Cabin',
    location: 'Chicago',
    imageUrl: 'assets/images/propertyone.jpeg',
  ),
  Property(
    name: 'Beach House',
    location: 'San Diego',
    imageUrl: 'assets/images/propertyone.jpeg',
  ),
];
