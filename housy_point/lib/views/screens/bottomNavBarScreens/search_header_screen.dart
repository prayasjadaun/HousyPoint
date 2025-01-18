// import 'package:flutter/material.dart';

// class TopSheetContent extends StatefulWidget {
//   final VoidCallback onClose;

//   const TopSheetContent({super.key, required this.onClose});

//   @override
//   _TopSheetContentState createState() => _TopSheetContentState();
// }

// class _TopSheetContentState extends State<TopSheetContent> {
//   final TextEditingController _searchController = TextEditingController();
//   bool isSearching = false;
//   List<String> popularSearches = [
//     "Luxury Apartments",
//     "Villas",
//     "Affordable Homes"
//   ];
//   List<String> searchResults = [];

//   Future<void> fetchSearchResults(String query) async {
//     // Simulate API call
//     await Future.delayed(const Duration(seconds: 1));
//     setState(() {
//       searchResults =
//           List.generate(5, (index) => "$query Property ${index + 1}");
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       bottom: false,
//       top: true,
//       child: Scaffold(
//         body: Material(
//           elevation: 8,
//           child: Container(
//             color: Colors.red,
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: _searchController,
//                         decoration: InputDecoration(
//                           labelText: 'Search properties...',
//                           border: const OutlineInputBorder(),
//                           prefixIcon: const Icon(Icons.search),
//                           suffixIcon: _searchController.text.isNotEmpty
//                               ? IconButton(
//                                   icon: const Icon(Icons.clear),
//                                   onPressed: () {
//                                     setState(() {
//                                       _searchController.clear();
//                                       isSearching = false;
//                                       searchResults = [];
//                                     });
//                                   },
//                                 )
//                               : null,
//                         ),
//                         onChanged: (query) {
//                           if (query.isNotEmpty) {
//                             setState(() {
//                               isSearching = true;
//                             });
//                             fetchSearchResults(query);
//                           } else {
//                             setState(() {
//                               isSearching = false;
//                               searchResults = [];
//                             });
//                           }
//                         },
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close),
//                       onPressed: widget.onClose,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 if (!isSearching && popularSearches.isNotEmpty)
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Popular Searches:',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 8),
//                       Wrap(
//                         spacing: 8,
//                         children: popularSearches
//                             .map((search) => ActionChip(
//                                   label: Text(search),
//                                   onPressed: () {
//                                     _searchController.text = search;
//                                     setState(() {
//                                       isSearching = true;
//                                     });
//                                     fetchSearchResults(search);
//                                   },
//                                 ))
//                             .toList(),
//                       ),
//                     ],
//                   ),
//                 if (isSearching)
//                   ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: searchResults.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(searchResults[index]),
//                       );
//                     },
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
