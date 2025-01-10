import 'package:flutter/material.dart';
import 'package:housy_point/providers/shortlisted_provider.dart';
import 'package:housy_point/models/property_model.dart';
import 'package:provider/provider.dart';

class ShortlistedScreen extends StatelessWidget {
  const ShortlistedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shortlistProvider = Provider.of<ShortlistProvider>(context);
    final shortlistedProperties = shortlistProvider.shortlistedProperties;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Shortlisted Properties",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomElevatedButton(
                text: 'Properties',
                onPressed: () {},
              ),
              CustomElevatedButton(
                text: 'Projects',
                onPressed: () {},
              ),
              CustomElevatedButton(
                text: 'Locations',
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 5),
          // Display a message if no properties are shortlisted
          shortlistedProperties.isEmpty
              ? const Text('You have not shortlisted any properties yet.')
              : Expanded(
                  child: ListView.builder(
                    itemCount: shortlistedProperties.length,
                    itemBuilder: (context, index) {
                      final property = shortlistedProperties[index];
                      return ListTile(
                        title: Text(property.title),
                        subtitle: Text('\$${property.price}'),
                        leading: Image.asset(property.imageUrl),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            shortlistProvider.toggleShortlist(property);
                          },
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, color: Colors.black),
      ),
    );
  }
}
