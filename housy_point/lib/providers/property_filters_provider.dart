import 'package:flutter/material.dart';

class PropertyFilter {
  final String type;
  final String count;

  PropertyFilter({required this.type, required this.count});
}

class PropertyFiltersProvider extends ChangeNotifier {
  // Location State
  int _selectedLocationIndex = 0;
  final List<String> locations = ['INDIA', 'OVERSEAS'];

  int get selectedLocationIndex => _selectedLocationIndex;

  void setLocation(int index) {
    _selectedLocationIndex = index;
    notifyListeners();
  }

  // Property Type State
  int _selectedPropertyTypeIndex = 0;
  final List<String> propertyTypes = ['RESALE', 'RENT', 'COMMERCIAL'];

  int get selectedPropertyTypeIndex => _selectedPropertyTypeIndex;

  void setPropertyType(int index) {
    _selectedPropertyTypeIndex = index;
    notifyListeners();
  }

  // BHK State
  int? _selectedBHKIndex;
  final List<PropertyFilter> bhkTypes = [
    PropertyFilter(type: '5.5/5 BHK', count: '124'),
    PropertyFilter(type: '4.5/4 BHK', count: '246'),
    PropertyFilter(type: '3.5/3 BHK', count: '180'),
    PropertyFilter(type: '2.5/2 BHK', count: '110'),
    PropertyFilter(type: '1.5/1 BHK', count: '78'),
    PropertyFilter(type: 'Studio', count: '58'),
  ];

  int? get selectedBHKIndex => _selectedBHKIndex;

  void setBHK(int? index) {
    _selectedBHKIndex = index;
    notifyListeners();
  }

  // Deal Type State
  int _selectedDealTypeIndex = 0;
  final List<String> dealTypes = ['RESALE', 'RENTING', 'COMMERCIAL'];
  bool _isDistressDealsExpanded = true;

  int get selectedDealTypeIndex => _selectedDealTypeIndex;
  bool get isDistressDealsExpanded => _isDistressDealsExpanded;

  bool? get isLoading => null;

  get filteredProperties => null;

  get error => null;

  void setDealType(int index) {
    _selectedDealTypeIndex = index;
    notifyListeners();
  }

  void toggleDistressDeals() {
    _isDistressDealsExpanded = !_isDistressDealsExpanded;
    notifyListeners();
  }

  // Filter Results
  List<Map<String, dynamic>> getFilteredResults() {
    // Implement your filtering logic here based on the selected filters
    return []; // Return filtered data
  }

  // Reset Filters
  void resetFilters() {
    _selectedLocationIndex = 0;
    _selectedPropertyTypeIndex = 0;
    _selectedBHKIndex = null;
    _selectedDealTypeIndex = 0;
    _isDistressDealsExpanded = true;
    notifyListeners();
  }
}
