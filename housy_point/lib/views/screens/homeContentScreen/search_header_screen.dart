import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchHeaderDialog extends StatefulWidget {
  final Function(String) onSearch;
  final List<String> properties;
  final List<String> projects;
  final List<String> builders;

  const SearchHeaderDialog({
    Key? key,
    required this.onSearch,
    required this.properties,
    required this.projects,
    required this.builders,
  }) : super(key: key);

  @override
  _SearchHeaderDialogState createState() => _SearchHeaderDialogState();
}

class _SearchHeaderDialogState extends State<SearchHeaderDialog> {
  final List<String> imagePaths = [
    'assets/images/propertyone.jpeg',
    'assets/images/propertytwo.jpg',
    'assets/images/propertythree.jpg',
    'assets/images/propertyfour.jpg',
    'assets/images/propertyfive.jpg',
  ];

  late List<String> filteredProperties;
  late List<String> filteredProjects;
  late List<String> filteredBuilders;
  String searchQuery = "";
  bool _isLoading = true; // Track whether shimmer effect is active

  @override
  void initState() {
    super.initState();
    filteredProperties = widget.properties;
    filteredProjects = widget.projects;
    filteredBuilders = widget.builders;

    // Simulate a 3-second delay before showing the actual UI
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _filterSearchResults(String query) {
    final propertyResults = widget.properties
        .where(
            (property) => property.toLowerCase().contains(query.toLowerCase()))
        .toList();

    final projectResults = widget.projects
        .where((project) => project.toLowerCase().contains(query.toLowerCase()))
        .toList();

    final builderResults = widget.builders
        .where((builder) => builder.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      filteredProperties = propertyResults;
      filteredProjects = projectResults;
      filteredBuilders = builderResults;
      searchQuery = query;
    });
  }

  // Shimmer Effects----------------------
  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 40,
          ),
          // Shimmer effect for the search bar
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 20),
          // Shimmer effect for the "Popular Places" section
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 150,
            height: 20,
            color: Colors.grey,
          ),
          const SizedBox(height: 10),
          // Shimmer effect for the list items
          ...List.generate(
            4,
            (index) => Expanded(
              child: Container(
                height: 100,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 5),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Main UI----------------------
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
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: _isLoading
              ? _buildShimmerEffect()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 45),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        onChanged: (query) {
                          widget.onSearch(query);
                          _filterSearchResults(query);
                        },
                        decoration: InputDecoration(
                          hintText:
                              'Search for properties, projects, or builders...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (searchQuery.isEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: const Text(
                          'Popular Places',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      ...widget.properties.asMap().entries.map((entry) {
                        final index = entry.key;
                        final property = entry.value;
                        return Expanded(
                          child: ListTile(
                            title: Container(
                              height: 80,
                              margin: const EdgeInsets.symmetric(vertical: 2,),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        imagePaths[index %
                                            imagePaths
                                                .length], // Use modulo to avoid index out of bounds
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            property,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop(property);
                            },
                          ),
                        );
                      }),
                    ],
                    if (searchQuery.isNotEmpty)
                      Expanded(
                        child: ListView(
                          children: [
                            if (filteredProperties.isNotEmpty)
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Properties',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ...filteredProperties.map((property) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.location_city,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                    title: Text(property),
                                    onTap: () {
                                      Navigator.of(context).pop(property);
                                    },
                                  ),
                                )),
                            if (filteredProjects.isNotEmpty)
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Projects',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ...filteredProjects.map((project) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.share_location_rounded,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                    title: Text(project),
                                    onTap: () {
                                      Navigator.of(context).pop(project);
                                    },
                                  ),
                                )),
                            if (filteredBuilders.isNotEmpty)
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Builders',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ...filteredBuilders.map((builder) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.location_on,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                    title: Text(builder),
                                    onTap: () {
                                      Navigator.of(context).pop(builder);
                                    },
                                  ),
                                )),
                            if (filteredProperties.isEmpty &&
                                filteredProjects.isEmpty &&
                                filteredBuilders.isEmpty)
                              const Center(
                                child: Text(
                                  'No results found.',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}

void showSearchHeaderDialog(BuildContext context, List<String> properties,
    List<String> projects, List<String> builders, Function(String) onSearch) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Close",
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      return SearchHeaderDialog(
        onSearch: onSearch,
        properties: properties,
        projects: projects,
        builders: builders,
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: anim,
          curve: Curves.easeIn,
        )),
        child: child,
      );
    },
  );
}
