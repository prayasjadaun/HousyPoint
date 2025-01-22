import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class ConfigrationWidget extends StatefulWidget {
  const ConfigrationWidget({super.key});

  @override
  _ConfigrationWidgetState createState() => _ConfigrationWidgetState();
}

class _ConfigrationWidgetState extends State<ConfigrationWidget> {
  String selectedBhk = '5BHK'; // Default value

  Map<String, String> bhkImages = {
    '5BHK': 'assets/bhkImages/3BHK_crown_2.jpg',
    '4BHK': 'assets/bhkImages/3BHK_study_crown.jpg',
    '3BHK': 'assets/images/propertyone.jpeg',
    '2BHK': 'assets/images/propertytwo.jpg',
    '1BHK': 'assets/bhkImages/3BHK_crown_2.jpg',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: const Text(
              "CONFIGURATIONS",
              style: TextStyle(
                fontSize: 30,
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
          const SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['5BHK', '4BHK', '3BHK', '2BHK', '1BHK'].map((bhk) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedBhk = bhk; // Update the selected BHK
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 120,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF004240),
                      ),
                      child: Center(
                          child: Text(
                        bhk,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      )),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InstaImageViewer(
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(bhkImages[selectedBhk]!),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
