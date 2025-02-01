import 'package:flutter/material.dart';
import 'package:housy_point/controllers/providers/bottomNavProvider/shortlisted_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ShortlistedScreen extends StatefulWidget {
  ShortlistedScreen({super.key});

  @override
  State<ShortlistedScreen> createState() => _ShortlistedScreenState();
}

class _ShortlistedScreenState extends State<ShortlistedScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Delay the shimmer effect by 3 seconds after the UI renders
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  Widget _buildShimmerEffect() {
    return SafeArea(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // Shimmer effect for the search bar
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              width: MediaQuery.of(context).size.height * 1/4,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 20),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              spacing: 10,
              children: [
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
                ),
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
                ),
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 1),
              width: double.infinity,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              width: MediaQuery.of(context).size.height * 1/3,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shortlistProvider = Provider.of<ShortlistProvider>(context);
    final shortlistedProperties = shortlistProvider.shortlistedProperties;

    // Get the current theme (dark or light mode)
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Dynamic colors based on the theme
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final buttonColor = isDarkMode ? Colors.tealAccent : Colors.green.shade900;
    final dividerColor =
        isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300;

    return _isLoading
        ? _buildShimmerEffect()
        : SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.all(10),
              color: backgroundColor, // Set background color based on the theme
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shortlisted Properties",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomElevatedButton(
                        text: 'Properties',
                        onPressed: () {},
                        buttonColor: buttonColor,
                      ),
                      CustomElevatedButton(
                        text: 'Projects',
                        onPressed: () {},
                        buttonColor: buttonColor,
                      ),
                      CustomElevatedButton(
                        text: 'Locations',
                        onPressed: () {},
                        buttonColor: buttonColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Divider(
                    color: dividerColor, // Set divider color based on the theme
                  ),
                  const SizedBox(height: 5),
                  // Display a message if no properties are shortlisted
                  shortlistedProperties.isEmpty
                      ? Text(
                          'You have not shortlisted any properties yet.',
                          style: TextStyle(color: textColor),
                        )
                      : Expanded(
                          child: _isLoading
                              ? _buildShimmerEffect()
                              : ListView.builder(
                                  itemCount: shortlistedProperties.length,
                                  itemBuilder: (context, index) {
                                    final property =
                                        shortlistedProperties[index];
                                    return ListTile(
                                      title: Text(property.title,
                                          style: TextStyle(color: textColor)),
                                      subtitle: Text('\₹${property.price} \Cr',
                                          style: TextStyle(color: textColor)),
                                      leading: Image.asset(property.imageUrl),
                                      trailing: IconButton(
                                        icon: Icon(
                                          Icons.favorite,
                                          color: isDarkMode
                                              ? Colors.redAccent
                                              : Colors.red,
                                        ),
                                        onPressed: () {
                                          shortlistProvider
                                              .toggleShortlist(property);
                                        },
                                      ),
                                    );
                                  },
                                ),
                        ),
                ],
              ),
            ),
          );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: buttonColor),
        backgroundColor: buttonColor.withOpacity(0.1),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: buttonColor),
      ),
    );
  }
}
