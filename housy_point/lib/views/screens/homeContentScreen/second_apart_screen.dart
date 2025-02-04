import 'dart:async';
import 'package:flutter/material.dart';
import 'package:housy_point/controllers/providers/propertiesProvider/property_slider_provider.dart';
import 'package:housy_point/views/widgets/utils/apartmentListingItems/landmark_widget.dart';
import 'package:housy_point/views/widgets/utils/apartmentListingItems/open_googlemap.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../widgets/utils/apartmentListingItems/configuration_widget.dart';
import '../../widgets/utils/apartmentListingItems/download_resources.dart';
import '../../widgets/utils/apartmentListingItems/master_layout_widget.dart';

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
                  builder: (context) => SecondApartScreen(),
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
                                  'Housy Point Property',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('Iffcco Chawk Gurugram'),
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

class SecondApartScreen extends StatefulWidget {
  late final AmenityItems amenity;

  @override
  _SecondApartScreenState createState() => _SecondApartScreenState();
}

class _SecondApartScreenState extends State<SecondApartScreen> {
  final List<String> propertyImages = [
    'assets/images/propertyone.jpeg',
    'assets/images/propertytwo.jpg',
    'assets/images/propertythree.jpg',
    'assets/images/propertyfour.jpg',
    'assets/images/propertyfive.jpg',
  ];

  final List<AmenityItems> amenityitems = [
    AmenityItems(name: 'Basket Ball', iconName: '🏀'),
    AmenityItems(name: 'Themed Garden', iconName: '⛲️'),
    AmenityItems(name: 'Golf Putting', iconName: '⛳️⛳️'),
    AmenityItems(name: 'Swimming Pool', iconName: '🏊🏻'),
    AmenityItems(name: 'Gym', iconName: '🏋🏻'),
    AmenityItems(name: 'Kids Play Area', iconName: '🛝🛝'),
    AmenityItems(name: 'Sports', iconName: '🚵🏻‍♀️'),
    AmenityItems(name: 'Smoke Free', iconName: '🚬'),
  ];
  final List<Color> iconBgColor = [
    Colors.green.shade300,
    Colors.red.shade300,
    Colors.white,
    Colors.blue.shade300,
    Colors.deepPurple.shade300,
    Colors.yellow.shade300,
    Colors.pink.shade300,
    Colors.orange.shade300,
    Colors.brown.shade300,
    Colors.grey.shade300,
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
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       Container(
        //           height: 50,
        //           width: 150,
        //           child: Center(
        //               child: Image.asset(
        //             'assets/applogos/white_logo_point.jpg',
        //           ))),
        //       CircleAvatar(
        //         backgroundColor: Colors.white,
        //         child: Icon(
        //           Icons.favorite,
        //           color: Colors.black,
        //         ),
        //       ),
        //       SizedBox(
        //         width: 10,
        //       ),
        //       CircleAvatar(
        //         backgroundColor: Colors.white,
        //         child: Icon(
        //           Icons.share,
        //           color: Colors.black,
        //         ),
        //       )
        //     ],
        //   ),
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
                              Icons.arrow_back_ios_new_sharp,
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
                                Icons.favorite_border_outlined,
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
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      height: 70,
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
                              margin: const EdgeInsets.symmetric(horizontal: 5),
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
                                borderRadius: BorderRadius.circular(10),
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
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            Text(
                              "\$1900/",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w900),
                            ),
                            Text(
                              "Month",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Text(
                      'Housy Point Property',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    // Description--------------
                    const Text(
                      'Description',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    // Listing Agent-----------
                    const Text(
                      'Listing Broker',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                    SizedBox(
                      height: 10,
                    ),
                    // Amenties ----------------------
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: const Text(
                              "AMENITIES",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            height: 2,
                            width: 80,
                            color: Colors.amber,
                          ),
                        ]),
                          const SizedBox(height: 10),
                    // Amenities Container
                    Container(
                      height: 260,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(20)),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 1),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, // Number of columns
                          mainAxisSpacing: 10, // Space between rows
                        ),
                        itemCount: amenityitems.length,
                        itemBuilder: (context, index) {
                          // Handle null iconName or name
                          String icon = amenityitems[index]
                              .iconName; // Fallback to a default icon

                          return Column(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center items vertically
                            crossAxisAlignment: CrossAxisAlignment
                                .center, // Center items horizontally
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    // border: Border.all(color: Colors.red),
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.grey.shade200),
                                child: Center(
                                  child: Text(
                                    icon,
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                              ),
                              // Small gap between icon and text
                              Expanded(
                                child: Text(
                                  maxLines: 2,
                                  softWrap: true,
                                  amenityitems[index].name,
                                  textAlign:
                                      TextAlign.center, // Center the text
                                  // overflow: TextOverflow
                                  //   .ellipsis, // Add ellipsis if text overflows
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    // LandMark Widget-------------
                    Container(
                        height: 600,
                        width: double.infinity,
                        child: LandmarksWidget()),
                    // Location Widget
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: const Text(
                              "LOCATION",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            height: 2,
                            width: 80,
                            color: Colors.amber,
                          ),
                        ]),
                    SizedBox(
                      height: 10,
                    ),
                    OpenMapFromBackend(),

                    SizedBox(
                      height: 20,
                    ),
                    // Master Layout Widget----------------
                    MasterLayoutWidget(),
                    // Configration Widget ----------
                    ConfigrationWidget(),
                    SizedBox(
                      height: 20,
                    ),

                    // Download Resources------------
                    Container(height: 300, child: DownloadResources()),
                    Container(child: Text(''),)
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
  final String iconName;
  AmenityItems({required this.name, required this.iconName});
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
        const SizedBox(width: 4),
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
