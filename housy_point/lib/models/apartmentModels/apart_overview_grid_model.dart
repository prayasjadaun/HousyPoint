import"package:flutter/material.dart";

class PremiumOverviewGridModel extends StatelessWidget {
  const PremiumOverviewGridModel({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildPremiumContainer(
          icon: Icons.location_on,
          title: 'LOCATION',
          content: 'Sector 111, Dwarka Expressway\nGurgaon, Haryana, India',
        ),
        _buildPremiumContainer(
          icon: Icons.dashboard,
          title: 'CONFIGURATION',
          content: '3 BHK\n4 BHK\nPenthouse',
        ),
        _buildPremiumContainer(
          icon: Icons.map,
          title: 'MASTER LAYOUT',
          content: 'Available in PDF format',
        ),
        _buildPremiumContainer(
          icon: Icons.place,
          title: 'LANDMARKS',
          content: 'Near Metro Station\nShopping Mall Nearby',
        ),
        _buildPremiumContainer(
          icon: Icons.apartment,
          title: 'AMENITIES',
          content: '50+ Amenities\nGym, Pool, Park',
        ),
        _buildPremiumContainer(
          icon: Icons.payment,
          title: 'PAYMENT PLAN',
          content: '10:90\n40:60\n80:20',
        ),
        _buildPremiumContainer(
          icon: Icons.price_change,
          title: 'PRICE RANGE',
          content: '₹2.25 Cr - ₹4.75 Cr',
        ),
        _buildPremiumContainer(
          icon: Icons.verified_user,
          title: 'RERA DETAILS',
          content: 'GGM/687/419/2023/31.',
        ),
      ],
    );
  }

  Widget _buildPremiumContainer({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon with circular background
          Expanded(
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Color(0xFF004240),
                size: 28,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Title
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF004240),
            ),
          ),
          const SizedBox(height: 8),
          // Divider
          Divider(color: Colors.grey.shade300, thickness: 1),
          const SizedBox(height: 8),
          // Content
          Text(
            content,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
              height: 1.4,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
