import 'package:flutter/material.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF004240),
          title: Center(
            child: Container(
                height: 70,
                width: 290,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset('assets/applogos/logo.png')),
          ),),
      body: SafeArea(
        child: SingleChildScrollView(
          // scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Basic Details',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
                Text(
                  'STEP 1 OF 3',
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      color: Colors.grey.shade600),
                ),
                // Title------------------
                Title(
                  text: "You're looking to?",
                ),
                // Buttons Row----------
                Wrap(
                  spacing: 5,
                  runSpacing: 10,
                  children: [
                    Buttoncontainer(buttontext: 'Sell'),
                    Buttoncontainer(buttontext: 'Rent/Lease'),
                    Buttoncontainer(buttontext: 'Paying Guest'),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                // Title------------------
                Title(
                  text: "What kind of property?",
                ),
                // Buttons Row----------
                Wrap(
                  spacing: 5,
                  runSpacing: 10,
                  children: [
                    Buttoncontainer(buttontext: 'Residential'),
                    Buttoncontainer(buttontext: 'Commercial'),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                // Title------------------
                Title(
                  text: "Select Property Type",
                ),
                // Buttons Row----------
                Wrap(
                  spacing: 5, // Horizontal spacing between buttons
                  runSpacing: 10, // Vertical spacing between rows
                  children: [
                    Buttoncontainer(buttontext: 'Apartment'),
                    Buttoncontainer(buttontext: 'Independent House/ Villa'),
                    Buttoncontainer(buttontext: 'Independent/ Builder Floor'),
                    Buttoncontainer(buttontext: 'Plot/ Land'),
                    Buttoncontainer(buttontext: 'Farm House'),
                    Buttoncontainer(buttontext: '1 RK/ Studio Apartment'),
                    Buttoncontainer(buttontext: 'Serviced Apartment'),
                    Buttoncontainer(buttontext: 'Others'),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Title(
                  text: "Where is your property located?",
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'City',
                    label: Text('Location'),
                    labelStyle: TextStyle(color: Colors.grey.shade900),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(Icons.location_searching),
                    SizedBox(width: 8),
                    Text(
                      'Detect my location',
                      style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                // Bedroom Container
                Title(
                  text: 'Add Room Details',
                ),
                Text('No. of Bedrooms'),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 10, // Horizontal spacing between buttons
                  runSpacing: 10, // Vertical spacing between rows
                  children: [
                    Buttoncontainer(buttontext: '1'),
                    Buttoncontainer(buttontext: '2'),
                    Buttoncontainer(buttontext: '3'),
                    Buttoncontainer(buttontext: '4'),
                    Buttoncontainer(buttontext: '5'),
                    Buttoncontainer(buttontext: '5+ '),
                  ],
                ),
                SizedBox(height: 20),
                Text('No. of Bathrooms'),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 10, // Horizontal spacing between buttons
                  runSpacing: 10, // Vertical spacing between rows
                  children: [
                    Buttoncontainer(buttontext: '1'),
                    Buttoncontainer(buttontext: '2'),
                    Buttoncontainer(buttontext: '3'),
                    Buttoncontainer(buttontext: '4'),
                    Buttoncontainer(buttontext: '4+'),
                  ],
                ),
                SizedBox(height: 20),
                Text('Balconies'),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 10, // Horizontal spacing between buttons
                  runSpacing: 10, // Vertical spacing between rows
                  children: [
                    Buttoncontainer(buttontext: '0'),
                    Buttoncontainer(buttontext: '1'),
                    Buttoncontainer(buttontext: '2'),
                    Buttoncontainer(buttontext: '3'),
                    Buttoncontainer(buttontext: 'More than 3'),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                // Details Items----------------------------------
                Title(
                  text: 'Add Area Details',
                ),
                Text('Atleast one area type is mendatory'),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 5,
                  runSpacing: 8,
                  children: [
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
                SizedBox(height: 30),
                Title(
                  text: "Floor Details",
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Total Floors',
                    label: Text('Total Floors'),
                    labelStyle: TextStyle(color: Colors.grey.shade900),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Title(
                  text: 'Availability Status',
                ),

                SizedBox(
                  height: 5,
                ),
                Wrap(
                  spacing: 10, // Horizontal spacing between buttons
                  runSpacing: 10, // Vertical spacing between rows
                  children: [
                    Buttoncontainer(buttontext: 'Ready to move'),
                    Buttoncontainer(buttontext: 'Under construction'),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Title(
                  text: 'Ownership',
                ),

                SizedBox(
                  height: 5,
                ),
                Wrap(
                  spacing: 10, // Horizontal spacing between buttons
                  runSpacing: 10, // Vertical spacing between rows
                  children: [
                    Buttoncontainer(buttontext: 'Freehold'),
                    Buttoncontainer(buttontext: 'Leasehold'),
                    Buttoncontainer(buttontext: 'Co-operative society'),
                    Buttoncontainer(buttontext: 'Power of Attorney'),
                  ],
                ),
                SizedBox(height: 30),
                Title(
                  text: "Price Details",
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '₹ Expected Price',
                    label: Text('₹ Expected Price'),
                    labelStyle: TextStyle(color: Colors.grey.shade900),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Wrap(
                  children: [
                    CheckBoxText(checkText: "All inclusive price"),
                    CheckBoxText(checkText: "Price Negotiable"),
                    CheckBoxText(checkText: "Tax and Govt. charges excluded"),
                  ],
                ),
                SizedBox(height: 30),
                Title(
                  text: "What makes your property unique",
                ),
                Text(
                    'Adding description will increase your listing visibility'),
                SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: TextField(
                    expands: true,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w300),
                      hintText:
                          "Share some details about your property like spacius rooms, well maintained facilities..",
                      labelStyle: TextStyle(color: Colors.grey.shade900),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurple.shade900,
                  ),
                  child: Center(
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
  Title({
    super.key,
    this.text,
  });
  final String? text;
  // final String Buttontext;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Check if `text` is not null before rendering it
          if (text != null)
            Text(
              text!,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class Buttoncontainer extends StatelessWidget {
  Buttoncontainer({super.key, required this.buttontext});
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
              style: TextStyle(
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
              labelStyle: TextStyle(color: Colors.grey.shade800),
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
                          style: TextStyle(fontSize: 14, color: Colors.black),
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
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
