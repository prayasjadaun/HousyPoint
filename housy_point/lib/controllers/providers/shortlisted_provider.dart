import 'package:flutter/material.dart';
import 'package:housy_point/models/distress_model.dart';

class ShortlistProvider extends ChangeNotifier {
  final List<Distress> _shortlistedProperties = [];

  List<Distress> get shortlistedProperties => _shortlistedProperties;

  void addToShortlist(Distress Distress) {
    if (!_shortlistedProperties.contains(Distress)) {
      _shortlistedProperties.add(Distress);
      notifyListeners();
    }
  }

  void removeFromShortlist(Distress Distress) {
    _shortlistedProperties.remove(Distress);
    notifyListeners();
  }

  // Toggle Distress in shortlist
  void toggleShortlist(Distress Distress) {
    if (_shortlistedProperties.contains(Distress)) {
      shortlistedProperties.remove(Distress); // Remove if already shortlisted
    } else {
      shortlistedProperties.add(Distress); // Add if not shortlisted
    }
    notifyListeners(); // Notify listeners to rebuild the UI
  }
}
