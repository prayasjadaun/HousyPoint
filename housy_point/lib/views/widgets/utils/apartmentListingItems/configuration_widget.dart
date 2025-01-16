import 'package:flutter/material.dart';
import 'package:housy_point/views/widgets/utils/apartmentListingItems/master_layout_widget.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class ConfigrationWidget extends StatelessWidget {
  const ConfigrationWidget({super.key});

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomContainer(
                  text: '5BHK',
                ),
                SizedBox(
                  width: 10,
                ),
                CustomContainer(
                  text: '4BHK',
                ),
                CustomContainer(
                  text: '3BHK',
                ),
                CustomContainer(
                  text: '2BHK',
                ),
                CustomContainer(
                  text: '1BHK',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                InstaImageViewer(
                    child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/3BHK_study_crown.jpg',
                      ),
                    ),
                  ),
                )),
                SizedBox(
                  width: 10,
                ),
                InstaImageViewer(
                    child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(color: Colors.grey.shade400),
                        vertical: BorderSide(color: Colors.grey.shade400)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/3BHK_crown_2.jpg'),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
