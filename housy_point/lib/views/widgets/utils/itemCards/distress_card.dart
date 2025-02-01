import 'package:flutter/material.dart';
import 'package:housy_point/models/distress_model.dart';
import 'package:housy_point/controllers/providers/bottomNavProvider/shortlisted_provider.dart';
import 'package:provider/provider.dart';

class DistressCard extends StatefulWidget {
  final Distress distressProperty;

  const DistressCard({super.key, required this.distressProperty});

  @override
  _DistressCardState createState() => _DistressCardState();
}

class _DistressCardState extends State<DistressCard> {
  @override
  Widget build(BuildContext context) {
    final shortlistProvider = Provider.of<ShortlistProvider>(context);
    final isShortlisted = shortlistProvider.shortlistedProperties
        .contains(widget.distressProperty);

    return Container(
      // margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              widget.distressProperty.imageUrl,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Content Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent.withOpacity(0.3),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),

          Positioned(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  // padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Stack(
                      children: [
                        // Background blur effect
                        Positioned.fill(
                          child: Container(
                            color: Colors.black
                                .withOpacity(0.2), // Slight transparency
                          ),
                        ),
                        // Content
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.distressProperty.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 25,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      color: Colors.white, size: 20),
                                  const SizedBox(width: 6),
                                  Text(
                                    widget.distressProperty.location,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${widget.distressProperty.bhk} BHK Apartment',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '(NORTH Facing)',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              // Interested Button Container
                              Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.7),
                                      Colors.black.withOpacity(0.3),
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.center,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      height: 50,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '\₹${widget.distressProperty.price} \Cr',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          // Toggle shortlist state
                                          shortlistProvider.toggleShortlist(
                                              widget.distressProperty);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          height: 50,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.teal,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "INTERESTED",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Heart Icon
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  isShortlisted ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  // Toggle shortlist state
                  shortlistProvider.toggleShortlist(widget.distressProperty);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
