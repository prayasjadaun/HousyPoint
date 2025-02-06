// loan_calculator.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class LoanCalculator extends StatefulWidget {
  const LoanCalculator({Key? key}) : super(key: key);

  @override
  _LoanCalculatorState createState() => _LoanCalculatorState();
}

class _LoanCalculatorState extends State<LoanCalculator> {
  final _formKey = GlobalKey<FormState>();
  final _currencyFormat = NumberFormat.currency(
    symbol: '₹',
    decimalDigits: 2,
    locale: 'en_IN',
  );

  double _loanAmount = 100000;
  double _interestRate = 8.75;
  int _loanDuration = 1;
  String? _selectedBank;

  final List<String> _banks = [
    'HDFC Bank',
    'SBI',
    'ICICI Bank',
    'Axis Bank',
    'Kotak Mahindra Bank'
  ];

  Map<String, double> _calculateEMI() {
    double principal = _loanAmount;
    double rate = _interestRate / 12 / 100;
    int time = _loanDuration * 12;

    double emi =
        principal * rate * pow((1 + rate), time) / (pow((1 + rate), time) - 1);
    double totalPayment = emi * time;
    double totalInterest = totalPayment - principal;

    return {
      'emi': emi,
      'totalInterest': totalInterest,
      'totalPayment': totalPayment,
      'principal': principal,
    };
  }

  @override
  Widget build(BuildContext context) {
    final calculations = _calculateEMI();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.grey.shade50,
            ],
          ),
        ),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Home Loan Calculator',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 22
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Calculate your EMI and plan your loan better',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 32),

                // Bank Selection
                DropdownButtonFormField<String>(
                  value: _selectedBank,
                  decoration: InputDecoration(
                    labelText: 'Select your bank',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: _banks.map((bank) {
                    return DropdownMenuItem(
                      value: bank,
                      child: Text(
                        bank,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedBank = value;
                    });
                  },
                ),
                const SizedBox(height: 24),

                // Loan Amount Slider
                Text(
                  'Loan Amount: ${_currencyFormat.format(_loanAmount)}',
                  style: TextStyle(color: Colors.black),
                  //  Theme.of(context).textTheme.titleMedium,
                ),
                Slider(
                  value: _loanAmount,
                  min: 100000,
                  max: 10000000,
                  divisions: 100,
                  activeColor: Colors.blue[700],
                  onChanged: (value) {
                    setState(() {
                      _loanAmount = value;
                    });
                  },
                ),

                // Loan Duration Slider
                Text(
                  'Loan Duration: $_loanDuration years',
                  style: TextStyle(color: Colors.black),
                  // Theme.of(context).textTheme.titleMedium
                ),
                Slider(
                  value: _loanDuration.toDouble(),
                  min: 1,
                  max: 30,
                  divisions: 29,
                  activeColor: Colors.blue[700],
                  onChanged: (value) {
                    setState(() {
                      _loanDuration = value.round();
                    });
                  },
                ),

                // Interest Rate Slider
                Text(
                  'Interest Rate: $_interestRate%',
                  style: TextStyle(color: Colors.black),
                  // style: Theme.of(context).textTheme.titleMedium,
                ),
                Slider(
                  value: _interestRate,
                  min: 5,
                  max: 20,
                  divisions: 150,
                  activeColor: Colors.blue[700],
                  onChanged: (value) {
                    setState(() {
                      _interestRate = double.parse(value.toStringAsFixed(2));
                    });
                  },
                ),

                const SizedBox(height: 32),

                // Results Section
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Pie Chart
                      SizedBox(
                        height: 200,
                        child: PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                color: Colors.blue[700],
                                value: calculations['principal']!,
                                title: 'Principal',
                                radius: 80,
                              ),
                              PieChartSectionData(
                                color: Colors.pink[400],
                                value: calculations['totalInterest']!,
                                title: 'Interest',
                                radius: 80,
                              ),
                            ],
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Monthly EMI
                      Text(
                        'Monthly EMI',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _currencyFormat.format(calculations['emi']),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 24),

                      // Breakdown
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildBreakdownItem(
                            'Principal',
                            calculations['principal']!,
                            Colors.blue[700]!,
                          ),
                          _buildBreakdownItem(
                            'Interest',
                            calculations['totalInterest']!,
                            Colors.pink[400]!,
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          _buildBreakdownItem(
                            'Total Payable',
                            calculations['totalPayment']!,
                            Colors.grey[800]!,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBreakdownItem(String label, double amount, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _currencyFormat.format(amount),
          style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              overflow: TextOverflow.visible),
        ),
      ],
    );
  }
}

double pow(double x, int y) {
  double result = 1;
  for (int i = 0; i < y; i++) {
    result *= x;
  }
  return result;
}
