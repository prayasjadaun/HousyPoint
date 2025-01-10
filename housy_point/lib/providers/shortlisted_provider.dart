import 'package:flutter/material.dart';

import '../models/property_model.dart';

class ShortlistProvider extends ChangeNotifier {
  final List<Property> _shortlistedProperties = [];

  List<Property> get shortlistedProperties => _shortlistedProperties;

  void addToShortlist(Property property) {
    if (!_shortlistedProperties.contains(property)) {
      _shortlistedProperties.add(property);
      notifyListeners();
    }
  }

  void removeFromShortlist(Property property) {
    _shortlistedProperties.remove(property);
    notifyListeners();
  }

  // Toggle property in shortlist
  void toggleShortlist(Property property) {
    if (_shortlistedProperties.contains(property)) {
      shortlistedProperties.remove(property); // Remove if already shortlisted
    } else {
      shortlistedProperties.add(property); // Add if not shortlisted
    }
    notifyListeners(); // Notify listeners to rebuild the UI
  }
}
