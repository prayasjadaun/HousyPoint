import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  bool _isLoading = true; // Track whether shimmer effect is active

  @override
  void initState() {
    super.initState();

    // Simulate a 3-second delay before showing the actual UI
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shimmer effect for the title
            Container(
              width: 200,
              height: 24,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            // Shimmer effect for the subtitle
            Container(
              width: 100,
              height: 14,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            // Shimmer effect for the buttons
            Wrap(
              spacing: 5,
              runSpacing: 10,
              children: List.generate(
                3,
                (index) => Container(
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Shimmer effect for the text fields
            ...List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      height: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF004240),
        title: Center(
          child: Container(
            height: 70,
            width: 290,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.asset('assets/applogos/logo.png'),
          ),
        ),
      ),
      body: SafeArea(
        child: _isLoading
            ? _buildShimmerEffect()
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Add Basic Details',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                      Text(
                        'STEP 1 OF 3',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: Colors.grey.shade600),
                      ),
                      // Title------------------
                      const Title(
                        text: "You're looking to?",
                      ),
                      // Buttons Row----------
                      Wrap(
                        spacing: 5,
                        runSpacing: 10,
                        children: const [
                          Buttoncontainer(buttontext: 'Sell'),
                          Buttoncontainer(buttontext: 'Rent/Lease'),
                          Buttoncontainer(buttontext: 'Paying Guest'),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Title------------------
                      const Title(
                        text: "What kind of property?",
                      ),
                      // Buttons Row----------
                      Wrap(
                        spacing: 5,
                        runSpacing: 10,
                        children: const [
                          Buttoncontainer(buttontext: 'Residential'),
                          Buttoncontainer(buttontext: 'Commercial'),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Title------------------
                      const Title(
                        text: "Select Property Type",
                      ),
                      // Buttons Row----------
                      Wrap(
                        spacing: 5, // Horizontal spacing between buttons
                        runSpacing: 10, // Vertical spacing between rows
                        children: const [
                          Buttoncontainer(buttontext: 'Apartment'),
                          Buttoncontainer(
                              buttontext: 'Independent House/ Villa'),
                          Buttoncontainer(
                              buttontext: 'Independent/ Builder Floor'),
                          Buttoncontainer(buttontext: 'Plot/ Land'),
                          Buttoncontainer(buttontext: 'Farm House'),
                          Buttoncontainer(buttontext: '1 RK/ Studio Apartment'),
                          Buttoncontainer(buttontext: 'Serviced Apartment'),
                          Buttoncontainer(buttontext: 'Others'),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Title(
                        text: "Where is your property located?",
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'City',
                          label: Text('Location'),
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_searching),
                          const SizedBox(width: 8),
                          Text(
                            'Detect my location',
                            style: TextStyle(
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Bedroom Container
                      const Title(
                        text: 'Add Room Details',
                      ),
                      const Text('No. of Bedrooms'),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        spacing: 10, // Horizontal spacing between buttons
                        runSpacing: 10, // Vertical spacing between rows
                        children: const [
                          Buttoncontainer(buttontext: '1'),
                          Buttoncontainer(buttontext: '2'),
                          Buttoncontainer(buttontext: '3'),
                          Buttoncontainer(buttontext: '4'),
                          Buttoncontainer(buttontext: '5'),
                          Buttoncontainer(buttontext: '5+ '),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text('No. of Bathrooms'),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        spacing: 10, // Horizontal spacing between buttons
                        runSpacing: 10, // Vertical spacing between rows
                        children: const [
                          Buttoncontainer(buttontext: '1'),
                          Buttoncontainer(buttontext: '2'),
                          Buttoncontainer(buttontext: '3'),
                          Buttoncontainer(buttontext: '4'),
                          Buttoncontainer(buttontext: '4+'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text('Balconies'),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        spacing: 10, // Horizontal spacing between buttons
                        runSpacing: 10, // Vertical spacing between rows
                        children: const [
                          Buttoncontainer(buttontext: '0'),
                          Buttoncontainer(buttontext: '1'),
                          Buttoncontainer(buttontext: '2'),
                          Buttoncontainer(buttontext: '3'),
                          Buttoncontainer(buttontext: 'More than 3'),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      // Details Items----------------------------------
                      const Title(
                        text: 'Add Area Details',
                      ),
                      const Text('Atleast one area type is mendatory'),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        spacing: 5,
                        runSpacing: 8,
                        children: const [
                          AreaInputField(
                            hintText: 'Enter Plot Area',
                            label: 'Plot Area',
                          ),
                          AreaInputField(
                            hintText: 'Enter Build-up Area',
                            label: 'Build-up Area',
                          ),
                          AreaInputField(
                            hintText: 'Enter Carpet Area',
                            label: 'Carpet Area',
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Title(
                        text: "Floor Details",
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Total Floors',
                          label: Text('Total Floors'),
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Title(
                        text: 'Availability Status',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Wrap(
                        spacing: 10, // Horizontal spacing between buttons
                        runSpacing: 10, // Vertical spacing between rows
                        children: const [
                          Buttoncontainer(buttontext: 'Ready to move'),
                          Buttoncontainer(buttontext: 'Under construction'),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Title(
                        text: 'Ownership',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Wrap(
                        spacing: 10, // Horizontal spacing between buttons
                        runSpacing: 10, // Vertical spacing between rows
                        children: const [
                          Buttoncontainer(buttontext: 'Freehold'),
                          Buttoncontainer(buttontext: 'Leasehold'),
                          Buttoncontainer(buttontext: 'Co-operative society'),
                          Buttoncontainer(buttontext: 'Power of Attorney'),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Title(
                        text: "Price Details",
                      ),
                      const TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '₹ Expected Price',
                          label: Text('₹ Expected Price'),
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Wrap(
                        children: const [
                          CheckBoxText(checkText: "All inclusive price"),
                          CheckBoxText(checkText: "Price Negotiable"),
                          CheckBoxText(
                              checkText: "Tax and Govt. charges excluded"),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Title(
                        text: "What makes your property unique",
                      ),
                      const Text(
                          'Adding description will increase your listing visibility'),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 200,
                        child: TextField(
                          expands: true,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintStyle: TextStyle(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w300),
                            hintText:
                                "Share some details about your property like spacius rooms, well maintained facilities..",
                            labelStyle: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepPurple.shade900,
                        ),
                        child: const Center(
                            child: Text(
                          'Post and Continue',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    super.key,
    this.text,
  });
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Check if `text` is not null before rendering it
          if (text != null)
            Text(
              text!,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class Buttoncontainer extends StatelessWidget {
  const Buttoncontainer({super.key, required this.buttontext});
  final String buttontext;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              buttontext,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AreaInputField extends StatefulWidget {
  final String hintText;
  final String label;

  const AreaInputField({
    Key? key,
    required this.hintText,
    required this.label,
  }) : super(key: key);

  @override
  _AreaInputFieldState createState() => _AreaInputFieldState();
}

class _AreaInputFieldState extends State<AreaInputField> {
  final List<String> units = [
    'sq.ft',
    'sq.yards',
    'sq.m.',
    'acres',
    'marla',
    'cents',
    'bigha',
    'kottah',
    'kanal',
    'grounds',
    'areas',
    'biswa',
    'guntha',
    'aankadam',
    'hectares',
    'rood',
    'chataks',
    'perch',
  ];

  String selectedUnit = 'sq.ft'; // Default unit

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              hintText: widget.hintText,
              labelText: widget.label,
              labelStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: Colors.white,
                value: selectedUnit,
                isExpanded: true,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedUnit = value; // Update the selected unit
                    });
                  }
                },
                items: units
                    .map(
                      (unit) => DropdownMenuItem<String>(
                        value: unit,
                        child: Text(
                          unit,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                      ),
                    )
                    .toList(),
                icon: const Icon(Icons.arrow_drop_down),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CheckBoxText extends StatefulWidget {
  final String checkText;

  const CheckBoxText({Key? key, required this.checkText}) : super(key: key);

  @override
  _CheckBoxTextState createState() => _CheckBoxTextState();
}

class _CheckBoxTextState extends State<CheckBoxText> {
  bool isChecked = false; // Track whether the checkbox is selected

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isChecked = !isChecked; // Toggle the checkbox state
            });
          },
          child: Icon(
            isChecked ? Icons.check_box : Icons.check_box_outline_blank,
            color: isChecked ? Colors.blue : Colors.grey,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          widget.checkText,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
