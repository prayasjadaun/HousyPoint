import 'package:flutter/material.dart';

class SearchHeaderDialog extends StatefulWidget {
  final Function(String) onSearch;
  final List<String> properties;

  const SearchHeaderDialog({
    Key? key,
    required this.onSearch,
    required this.properties,
  }) : super(key: key);

  @override
  _SearchHeaderDialogState createState() => _SearchHeaderDialogState();
}

class _SearchHeaderDialogState extends State<SearchHeaderDialog> {
  late List<String> filteredProperties;

  @override
  void initState() {
    super.initState();
    filteredProperties = widget.properties;
  }

  void _filterProperties(String query) {
    final results = widget.properties
        .where(
            (property) => property.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      filteredProperties = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Material(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        elevation: 4,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.all(15.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 30,
              ),
              const Text(
                'Search Properties',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (query) {
                  widget.onSearch(query);
                  _filterProperties(query);
                },
                decoration: InputDecoration(
                  hintText: 'Search for properties...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: filteredProperties.isNotEmpty
                    ? ListView.builder(
                        itemCount: filteredProperties.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(Icons.location_on),
                            title: Text(filteredProperties[index]),
                            onTap: () {
                              Navigator.of(context)
                                  .pop(filteredProperties[index]);
                            },
                          );
                        },
                      )
                    : const Center(
                        child: Text('No properties found.'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showSearchHeaderDialog(
    BuildContext context, List<String> properties, Function(String) onSearch) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Close",
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) {
      return SearchHeaderDialog(
        onSearch: onSearch,
        properties: properties,
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(anim),
        child: child,
      );
    },
  );
}
