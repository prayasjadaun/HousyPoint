import 'package:flutter/material.dart';

class PropertyFilters extends StatefulWidget {
  const PropertyFilters(
      {super.key,
      this.onLocationChanged,
      this.onPropertyTypeChanged,
      this.onBHKSelected,
      this.onDealTypeChanged,
      this.onDistressDealsExpandedChanged});

  final Function(int)? onLocationChanged;
  final Function(int)? onPropertyTypeChanged;
  final Function(int?)? onBHKSelected;
  final Function(int)? onDealTypeChanged;
  final Function(bool)? onDistressDealsExpandedChanged;

  @override
  State<PropertyFilters> createState() => _PropertyFiltersState();
}

class _PropertyFiltersState extends State<PropertyFilters> {
  final List<String> _developers = ['Developers', 'M3M', 'DLF', 'Central Park'];
  String _selectedDeveloper = 'Developers';

  int _selectedLocationIndex = 0;
  int _selectedPropertyTypeIndex = 0;
  int _selectedDealTypeIndex = 0;
  int? _selectedBHKIndex;
  final List<String> _locations = ['INDIA', 'OVERSEAS'];
  final List<String> _propertyTypes = ['RESALE', 'RENT', 'COMMERCIAL'];
  final List<Map<String, dynamic>> _bhkTypes = [
    {'type': '5.5 / 5 BHK', 'count': '124'},
    {'type': '4.5 / 4 BHK', 'count': '246'},
    {'type': '3.5 / 3 BHK', 'count': '180'},
    {'type': '2.5 / 2 BHK', 'count': '110'},
    {'type': '1.5 / 1 BHK', 'count': '78'},
    {'type': 'Studio', 'count': '58'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width,
      // margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              offset: Offset(2, 2),
              color: Colors.grey,
              blurRadius: 5.0,
            ),
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: Colors.white),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background Circle Decorations
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.circle,
                  color: Colors.green.withOpacity(0.1)),
            ),
          ),
          Positioned(
            left: -100,
            bottom: -100,
            child: Container(
              height: 300,
              width: 400,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.amber.withOpacity(0.1)),
            ),
          ),

          // Main content stacked on top
          Positioned(
            left: 10,
            right: 10,
            top: 0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLocationTabs(),
                  _buildPropertyTypeTabs(),
                  _buildBHKFilters(),
                  const SizedBox(height: 10),
                  // _buildDistressDeals(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationTabs() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Color(0xFF004240),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          ...List.generate(
            _locations.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 1),
              child: _buildLocationChip(
                _locations[index],
                index == _selectedLocationIndex,
                () => setState(() => _selectedLocationIndex = index),
              ),
            ),
          ),
          const Spacer(),
          _buildDeveloperDropdown(),
        ],
      ),
    );
  }

  Widget _buildDeveloperDropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: _selectedDeveloper,
        items: _developers.map((developer) {
          return DropdownMenuItem<String>(
              value: developer,
              child: Text(developer, style: TextStyle(color: Colors.white)));
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedDeveloper = value!;
          });
        },
        dropdownColor: Color(0xFF004240),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
      ),
    );
  }

  Widget _buildLocationChip(String label, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              label == 'INDIA' ? Icons.add_location : Icons.language,
              color: isSelected ? Colors.black : Colors.white,
              size: 18,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyTypeTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          _propertyTypes.length,
          (index) => InkWell(
            onTap: () => setState(() => _selectedPropertyTypeIndex = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: _selectedPropertyTypeIndex == index
                        ? Color(0xFF004240)
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                _propertyTypes[index],
                style: TextStyle(
                  fontSize: 14,
                  color: _selectedPropertyTypeIndex == index
                      ? Color(0xFF004240)
                      : Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBHKFilters() {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: List.generate(
        _bhkTypes.length,
        (index) {
          final bhkType = _bhkTypes[index]['type']!;
          final count = _bhkTypes[index]['count']!;
          return InkWell(
            onTap: () => setState(() {
              _selectedBHKIndex = _selectedBHKIndex == index ? null : index;
            }),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildBHKChip(bhkType, index == _selectedBHKIndex),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(3),
                    width: 120,
                    height: 35,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Text(
                          count,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBHKChip(String bhkType, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        bhkType,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
          color: isSelected ? Color(0xFF004240) : Colors.black,
        ),
      ),
    );
  }

  // Widget _buildDistressDeals() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       _dealTypes.isNotEmpty
  //           ? InkWell(
  //               onTap: () => setState(
  //                   () => _isDistressDealsExpanded = !_isDistressDealsExpanded),
  //               child: Padding(
  //                 padding:
  //                     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     const Text(
  //                       'DISTRESS DEALS',
  //                       style: TextStyle(
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.w900,
  //                       ),
  //                     ),
  //                     GestureDetector(
  //                       onTap: () {
  //                         setState(() {
  //                           _isDistressDealsExpanded =
  //                               !_isDistressDealsExpanded;
  //                         });
  //                         widget.onDistressDealsExpandedChanged
  //                             ?.call(_isDistressDealsExpanded);
  //                       },
  //                       child: AnimatedRotation(
  //                         turns: _isDistressDealsExpanded ? 0 : -0.25,
  //                         duration: const Duration(milliseconds: 200),
  //                         child: const Icon(
  //                           Icons.keyboard_arrow_down,
  //                           color: Colors.black,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             )
  //           : AnimatedCrossFade(
  //               firstChild: Container(
  //                 // margin: const EdgeInsets.symmetric(horizontal: 16),
  //                 decoration: BoxDecoration(
  //                   color: Colors.grey.shade200,
  //                   borderRadius: BorderRadius.circular(25),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Colors.grey.withOpacity(0.2),
  //                       spreadRadius: 1,
  //                       blurRadius: 4,
  //                       offset: const Offset(0, 2),
  //                     ),
  //                   ],
  //                 ),
  //                 child: Row(
  //                   children: [
  //                     Expanded(child: _buildDealTypeButton('RESALE', 0)),
  //                     Expanded(child: _buildDealTypeButton('RENTING', 1)),
  //                     Expanded(child: _buildDealTypeButton('COMMERCIAL', 2)),
  //                   ],
  //                 ),
  //               ),
  //               secondChild: const SizedBox.shrink(),
  //               crossFadeState: _isDistressDealsExpanded
  //                   ? CrossFadeState.showFirst
  //                   : CrossFadeState.showSecond,
  //               duration: const Duration(milliseconds: 200),
  //             ),
  //     ],
  //   );
  // }

  Widget _buildDealTypeButton(String text, int index) {
    final isSelected = _selectedDealTypeIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedDealTypeIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF004240) : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
