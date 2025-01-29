import 'package:flutter/material.dart';

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
  String searchQuery = ""; // Track the search query

  @override
  void initState() {
    super.initState();
    filteredProperties = widget.properties;
    filteredProjects = widget.projects;
    filteredBuilders = widget.builders;
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
      searchQuery = query; // Update the search query state
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
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
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
                  _filterSearchResults(query);
                },
                decoration: InputDecoration(
                  hintText: 'Search for properties, projects, or builders...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Only show 'Popular Places' if there is no search query
              if (searchQuery.isEmpty) ...[
                const Text(
                  'Popular Places',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                // Show popular properties
                ...widget.properties.map((property) => Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
              ],
              if (searchQuery.isNotEmpty)
                Expanded(
                  child: ListView(
                    children: [
                      // Show Properties if there are search results
                      if (filteredProperties.isNotEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('Properties',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
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

                      // Show Projects if there are search results
                      if (filteredProjects.isNotEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('Projects',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
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

                      // Show Builders if there are search results
                      if (filteredBuilders.isNotEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('Builders',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
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

                      // Show no results message if nothing matches
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
    transitionDuration: const Duration(milliseconds: 600),
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
