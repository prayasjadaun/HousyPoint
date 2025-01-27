import 'dart:async';
import 'package:flutter/material.dart';
import 'package:housy_point/controllers/providers/property_slider_provider.dart';
import 'package:housy_point/views/widgets/utils/apartmentListingItems/amenities_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SecondProperty extends StatelessWidget {
  const SecondProperty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PropertyDetailScreen(),
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
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                ),
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
                                SizedBox(height: 10),
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
  late final AmenityItems amenity;

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

  final List<AmenityItems> amenityitems = [
    AmenityItems(name: 'Basket Ball', icon: Icons.sports_basketball),
    AmenityItems(name: 'Themed Garden', icon: Icons.park),
    AmenityItems(name: 'Golf Putting', icon: Icons.golf_course),
    AmenityItems(name: 'Swimming Pool', icon: Icons.pool),
    AmenityItems(name: 'Gym', icon: Icons.fitness_center),
    AmenityItems(name: 'Kids Play Area', icon: Icons.child_friendly),
    AmenityItems(name: 'Tennis Court', icon: Icons.sports_tennis),
  ];

  @override
  Widget build(BuildContext context) {
    final propertySliderProvider =
        Provider.of<PropertySliderProvider>(context, listen: false);

    // Start auto-slide when the screen is loaded, only if the image list is not empty
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (propertyImages.isNotEmpty) {
        propertySliderProvider.startAutoSlide(propertyImages);
      }
    });

    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   title: ,
        // ),
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
                        key: ValueKey<String>(propertyImages[
                            propertySliderProvider.currentIndex]),
                        height: 400,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
                  // backbutton row
                  Positioned(
                    top: 50,
                    left: 15,
                    right: 15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.favorite,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.share,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: 5,
                    right: 5,
                    bottom: 20,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 10),
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
                              propertySliderProvider
                                  .resumeAutoSlide(propertyImages);
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
                        ),
                      ],
                    ),
                    const Text(
                      'Housy Point Property',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                        border: Border.all(color: Colors.grey.shade200)
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            IconWithText(
                                icon: Icons.location_on, text: 'Location'),
                                SizedBox(width: 5,),
                            IconWithText(
                                icon: Icons.square_sharp,
                                text: 'Configration'),
                            IconWithText(
                                icon: Icons.square_foot,
                                text: '2,567'),
                                IconWithText(
                                icon: Icons.location_on, text: 'Location'),
                            IconWithText(
                                icon: Icons.square_sharp,
                                text: 'Configration'),
                            IconWithText(
                                icon: Icons.square_foot,
                                text: '2,567'),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    // Description--------------
                    const Text(
                      'Description',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    // Listing Agent-----------
                    const Text(
                      'Listing Broker',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/boyProfile.png'),
                      ),
                      title: Text('Listing Agent'),
                      subtitle: Text('18392719103'),
                      trailing: Icon(Icons.phone),
                    ),
                    // Amenties --------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Amenities',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'see all',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    Container(
                      height: 300,
                      child: GridView.builder(
                        physics:
                            BouncingScrollPhysics(), // Optional, adjust based on your use case
                        scrollDirection: Axis.vertical,
                        shrinkWrap:
                            true, // Ensures the GridView takes up only as much space as needed
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5, // Number of columns
                          crossAxisSpacing: 5, // Space between columns
                          mainAxisSpacing: 15, // Space between rows
                          childAspectRatio:
                              1, // Aspect ratio of each grid item (1 means square)
                        ),
                        itemCount: amenityitems.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.center, // Center the items
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade300,
                                ),
                                child: Icon(
                                  amenityitems[index].icon,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 5),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    softWrap: false,
                                    maxLines: 2,
                                    amenityitems[index].name,
                                    textAlign:
                                        TextAlign.center, // Center the text
                                    overflow: TextOverflow
                                        .ellipsis, // Add ellipsis if text overflows
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 70,
          shape: CircularNotchedRectangle(),
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(10),
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
        ));
  }
}

class AmenityItems {
  final String name;
  final IconData icon;
  AmenityItems({required this.name, required this.icon});
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
        Icon(icon, size: 20, color: Colors.black),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
          // overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
  }
}
