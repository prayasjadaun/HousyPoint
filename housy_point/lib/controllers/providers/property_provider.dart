import 'dart:async';
import 'package:flutter/foundation.dart';

class PropertySliderProvider extends ChangeNotifier {
  int currentIndex = 0;
  Timer? _timer;
  bool isAutoSliding = true;

  PropertySliderProvider();

  void startAutoSlide(List<String> propertyImages) {
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

  void resumeAutoSlide() {
    // Wait for 3 seconds before resuming auto-slide and updating the border color
    Timer(const Duration(seconds: 3), () {
      isAutoSliding = true;
      notifyListeners(); // Notify listeners to resume the UI update.
      startAutoSlide([]); // Restart the auto-slide process.
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
