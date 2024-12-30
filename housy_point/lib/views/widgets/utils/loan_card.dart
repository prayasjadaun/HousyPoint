import 'package:flutter/material.dart';

class LoanCard extends StatelessWidget {
  final String text;

  const LoanCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        color: Colors.grey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.teal[900],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
