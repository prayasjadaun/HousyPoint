import 'package:flutter/material.dart';
import 'package:housy_point/models/distress_model.dart';

class ApartmentListing {
  final Distress distress;
  final List<String> images;
  final String type;
  final double rating;
  final int reviewCount;
  final String title;
  final String address;
  final VoidCallback? onBackPressed;
  final VoidCallback? onSharePressed;
  final VoidCallback? onFavoritePressed;
  final VoidCallback? onReadMorePressed;
  final VoidCallback? onBookNowPressed;

  ApartmentListing({
    required this.distress,
    this.images = const [],
    this.type = 'Apartment',
    this.rating = 0.0,
    this.reviewCount = 0,
    this.title = '',
    this.address = '',
    this.onBackPressed,
    this.onSharePressed,
    this.onFavoritePressed,
    this.onReadMorePressed,
    this.onBookNowPressed,
  });
}
