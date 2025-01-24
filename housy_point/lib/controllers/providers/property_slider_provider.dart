import 'dart:async';
import 'package:flutter/foundation.dart';

class PropertySliderProvider extends ChangeNotifier {
  int currentIndex = 0;
  Timer? _timer;
  bool isAutoSliding = true;

  PropertySliderProvider();

  void startAutoSlide(List<String> propertyImages) {
    if (propertyImages.isEmpty) {
      print("Error: No property images available to start the auto-slide.");
      return; // Don't proceed if the list is empty.
    }

    _timer?.cancel(); // Cancel any existing timer.

    // Start auto-sliding every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (isAutoSliding) {
        currentIndex = (currentIndex + 1) % propertyImages.length;
        notifyListeners(); // Notify listeners to update the UI.
      }
    });
  }

  void stopAutoSlide() {
    _timer?.cancel(); // Stop auto-slide when tapped.
    isAutoSliding = false;
  }

  void resumeAutoSlide(List<String> propertyImages) {
    // Ensure propertyImages is not empty before restarting the auto-slide
    if (propertyImages.isEmpty) {
      print("Error: No property images available to resume auto-slide.");
      return;
    }

    // Wait for 3 seconds before resuming auto-slide and updating the border color
    Timer(const Duration(seconds: 3), () {
      isAutoSliding = true;
      notifyListeners(); // Notify listeners to resume the UI update.
      startAutoSlide(propertyImages); // Restart the auto-slide process.
    });
  }

  void updateImageIndex(int index) {
    currentIndex = index;
    notifyListeners(); // Notify listeners to update the UI.
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
