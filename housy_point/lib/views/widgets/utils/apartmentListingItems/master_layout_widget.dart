import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class MasterLayoutWidget extends StatelessWidget {
  const MasterLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "MASTER LAYOUT",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomContainer(
                text: '12',
              ),
              CustomContainer(
                text: '10',
              ),
              CustomContainer(
                text: '20',
              )
            ],
          ),
          InstaImageViewer(
            child: Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage('assets/images/m3m_crown_masterplan.png')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.text, this.padding});
  final String text;
  final Padding? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
     
      width: 100,
      height: 30,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 5,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
          child: Text(
        text,
      )),
    );
  }
}
