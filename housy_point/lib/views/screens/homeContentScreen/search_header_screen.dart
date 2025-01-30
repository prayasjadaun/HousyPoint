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
    Future.delayed(const Duration(seconds: 2), () {
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
          SizedBox(height: 40,),
          // Shimmer effect for the search bar
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 20),
          // Shimmer effect for the "Popular Places" section
          Container(
            width: 150,
            height: 20,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          // Shimmer effect for the list items
          ...List.generate(
              4,
              (index) => Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
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
                    TextField(
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
                    const SizedBox(height: 10),
                    if (searchQuery.isEmpty) ...[
                      const Text(
                        'Popular Places',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),
                      ...widget.properties.map((property) => Expanded(
                        child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey.shade200,
                                child: Icon(
                                  Icons.location_city,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                              title: Container(
                                height: 50,
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(vertical: 8),
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    property,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pop(property);
                              },
                            ),
                      )),
                    ],
                    if (searchQuery.isNotEmpty)
                      Expanded(
                        child: ListView(
                          children: [
                            if (filteredProperties.isNotEmpty)
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text('Properties',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ...filteredProperties.map((property) => Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    leading: Icon(
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
                                child: Text('Projects',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ...filteredProjects.map((project) => Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    leading: Icon(
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
                                child: Text('Builders',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ...filteredBuilders.map((builder) => Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    leading: Icon(
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
                                child: Text('No results found.',
                                    style: TextStyle(color: Colors.grey)),
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
