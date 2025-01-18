import 'package:flutter/material.dart';

class DownloadResources extends StatelessWidget {
  const DownloadResources({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Title
      const SizedBox(height: 30),
      Center(
        child: const Text(
          "DOWNLOAD RESOURCES",
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
      SizedBox(
        height: 20,
      ),
      Container(
        height: 200,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomResourceCards(
              icon: Icons.menu_book_rounded,
              text: 'BROCHURE',
            ),
            SizedBox(
              width: 10,
            ),
            CustomResourceCards(
              icon: Icons.edit_document,
              text: 'RERA ',
            ),
          ],
        ),
      ),
    ]);
  }
}

class CustomResourceCards extends StatelessWidget {
  CustomResourceCards({super.key, required this.text, required this.icon});
  final text;
  final icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 160,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.black,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            onPressed: () {},
            child: Text(
              'Download',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
