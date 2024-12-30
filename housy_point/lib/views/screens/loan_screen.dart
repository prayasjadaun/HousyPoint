import 'package:flutter/material.dart';
import 'package:housy_point/views/widgets/utils/loan_card.dart';
import 'dart:async';

class LoanScreen extends StatefulWidget {
  const LoanScreen({super.key});

  @override
  State<LoanScreen> createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  late ScrollController _scrollController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Timer to scroll automatically
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_scrollController.hasClients) {
        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
          _scrollController.jumpTo(_scrollController.position.minScrollExtent);
        } else {
          _scrollController.animateTo(
            _scrollController.offset + 200,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the screen is disposed
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "HOME LOAN",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.teal[900],
            ),
          ),
          const SizedBox(height: 8),
          Divider(
            color: Colors.teal[900],
            thickness: 2,
            indent: 40,
            endIndent: 40,
          ),
          const SizedBox(height: 20),
          // Horizontal Scrolling with Two Cards Displayed
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              children: const [
                LoanCard(text: "Unlock the Best Home Loan Deals."),
                LoanCard(text: "Compare All Bank Offers."),
                LoanCard(text: "Get Pre-Approval for Your House."),
                LoanCard(text: "Low Interest Rates, High Approval Chances."),
                LoanCard(text: "Easy Application Process."),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
