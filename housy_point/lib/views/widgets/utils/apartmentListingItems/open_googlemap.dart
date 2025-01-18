import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenMapFromBackend extends StatelessWidget {
  // Backend-provided iframe link
  final String iframeUrl =
      "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d28067.893390311347!2d77.04493215!3d28.4347422!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390d186ec89f751b%3A0xdc2ab32fc4675cac!2sMedanta%E2%80%93The%20Medicity%2C%20Gurugram!5e0!3m2!1sen!2sin!4v1737010302618!5m2!1sen!2sin";

  void _openGoogleMaps() async {
    // Extracting coordinates from the iframe link (adjust as needed)
    final String coordinates = "28.4347422,77.04493215"; // Hardcoded for now
    final String googleMapsUrl = "https://www.google.com/maps?q=$coordinates";

    final Uri url = Uri.parse(googleMapsUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openGoogleMaps,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(15)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(vertical: 5),
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300)),
              child: Center(
                child: Text(
                  'Sector 111, Dwarka Expressway\nGurgaon, Haryana, India',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.green.shade900,
                  borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: Text(
                  'See in Maps',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
