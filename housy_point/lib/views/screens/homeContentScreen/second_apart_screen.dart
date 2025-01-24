import 'package:flutter/material.dart';
import 'package:housy_point/controllers/providers/property_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SecondProperty extends StatelessWidget {
  const SecondProperty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PropertyDetailScreen(),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Add a 2-second delay to show shimmer before showing the image
                  Hero(
                    tag: 'propertyImage',
                    child: FutureBuilder(
                      future: Future.delayed(const Duration(seconds: 3)),
                      builder: (context, snapshot) {
                        // Show shimmer effect during the delay
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    height: 200,
                                    decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20)

                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 1),
                                Container(
                                    margin:EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    height: 20,
                                    decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20)

                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 1/2),
                                Container(
                                    margin:EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    height: 20,
                                    decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20)

                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 1),
                                Container(
                                    margin:EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    height: 20,
                                    decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20)

                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 1/4),
                              ],
                            ),
                          );
                        } else {
                          // Once the delay is over, show the actual image
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    'assets/images/propertyone.jpeg',
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height:10),
                                Text(
                                  'Mark Willson Property',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('DHA, North Nazimabad, Lahore, Pakistan'),
                                SizedBox(height: 4),
                                Text('\$1900/Month'),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PropertyDetailScreen extends StatefulWidget {
  const PropertyDetailScreen({Key? key}) : super(key: key);

  @override
  _PropertyDetailScreenState createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  final List<String> propertyImages = [
    'assets/images/propertyone.jpeg',
    'assets/images/propertytwo.jpg',
    'assets/images/propertythree.jpg',
    'assets/images/propertyfour.jpg',
    'assets/images/propertyfive.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final propertySliderProvider =
        Provider.of<PropertySliderProvider>(context, listen: false);
    // Start auto-slide when the screen is loaded.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      propertySliderProvider.startAutoSlide(propertyImages);
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Property Details')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Consumer<PropertySliderProvider>(
                    builder: (context, slideProvider, _) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Image.asset(
                      propertyImages[propertySliderProvider.currentIndex],
                      key: ValueKey<String>(
                          propertyImages[propertySliderProvider.currentIndex]),
                      height: 400,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  );
                }),
                Positioned(
                  left: 5,
                  right: 5,
                  bottom: 20,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: propertyImages.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Stop auto-slide and change the index when a thumbnail is tapped.
                            propertySliderProvider.updateImageIndex(index);
                            propertySliderProvider.resumeAutoSlide();
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            width: 80,
                            decoration: BoxDecoration(
                              // border: Border.all(
                              //   color:
                              //       propertySliderProvider.currentIndex == index
                              //           ? Colors.blue
                              //           : Colors.grey.shade300,
                              //   width: 2,
                              // ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                propertyImages[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Home',
                        style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Text(
                            "\$1900/",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w900),
                          ),
                          Text(
                            "Month",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  ),
                  const Text(
                    'Housy Point Property',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  IconWithText(
                    icon: Icons.location_on,
                    text: 'Gurugram, Haryana',
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        IconWithText(icon: Icons.bed, text: '3 Bed'),
                        IconWithText(icon: Icons.bathtub, text: '2 Bath'),
                        IconWithText(
                            icon: Icons.square_foot, text: '2,567 Sqft'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Listing Broker',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/images/boyProfile.png',
                      ),
                    ),
                    title: Text('Listing Agent'),
                    subtitle: Text('18392719103'),
                    trailing: Icon(Icons.phone),
                  ),
                  Container(
                    padding:EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.purple.shade900,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        'B O O K N O W',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconWithText extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconWithText({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.black,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
  }
}
