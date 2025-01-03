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
  bool _isDistressDealsExpanded = true;

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
      padding: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            offset: Offset(5, 5),
            color: Colors.grey,
            blurRadius: 5.0,
          )
        ],
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFF5F5F5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLocationTabs(),
          _buildPropertyTypeTabs(),
          _buildBHKFilters(),
          const SizedBox(height: 10),
          _buildDistressDeals(),
        ],
      ),
    );
  }

  Widget _buildLocationTabs() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          // Location Chips
          ...List.generate(
            _locations.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 5),
              child: _buildLocationChip(
                _locations[index],
                index == _selectedLocationIndex,
                () => setState(() => _selectedLocationIndex = index),
              ),
            ),
          ),
          // Spacer to separate Developer dropdown
          const Spacer(),
          // Developer Dropdown
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
            child: Row(
              children: [
                // const Icon(Icons., size: 18),
                // const SizedBox(width: 5),
                Text(
                  developer,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedDeveloper = value!;
          });
        },
        dropdownColor: Colors.white,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
      ),
    );
  }

  Widget _buildLocationChip(String label, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              label == 'INDIA' ? Icons.add_location : Icons.language,
              color: isSelected ? Colors.black : Colors.black,
              size: 18,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.black,
                fontWeight: FontWeight.bold,
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
      // decoration: const BoxDecoration(color: Colors.grey),
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
                        ? Colors.teal
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                _propertyTypes[index],
                style: TextStyle(
                  fontSize: 12,
                  color: _selectedPropertyTypeIndex == index
                      ? Colors.teal
                      : Colors.black,
                  fontWeight: FontWeight.bold,
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
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(15),
              //     border: Border.all(color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
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
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Text(
                          count,
                          style: const TextStyle(
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
        // border: Border.all(
        //   color: isSelected ? Colors.teal : Colors.grey.shade300,
        // ),
      ),
      child: Text(
        bhkType,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.blue : Colors.black,
        ),
      ),
    );
  }

  Widget _buildDistressDeals() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isDistressDealsExpanded = !_isDistressDealsExpanded;
              widget.onDistressDealsExpandedChanged
                  ?.call(_isDistressDealsExpanded);
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'DISTRESS DEALS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AnimatedRotation(
                  turns: _isDistressDealsExpanded ? 0 : -0.25,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildDealTypeButton('RESALE', 0),
                _buildDealTypeButton('RENTING', 1),
                _buildDealTypeButton('COMMERCIAL', 2),
              ],
            ),
          ),
          secondChild: const SizedBox.shrink(),
          crossFadeState: _isDistressDealsExpanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }

  Widget _buildDealTypeButton(String label, int index) {
    final isSelected = _selectedDealTypeIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedDealTypeIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.teal : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
