import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class EMIStructureScreen extends StatefulWidget {
  @override
  _EMIStructureScreenState createState() => _EMIStructureScreenState();
}

class _EMIStructureScreenState extends State<EMIStructureScreen> {
  List<FlSpot> principalSpots = [];
  List<FlSpot> interestSpots = [];

  @override
  void initState() {
    super.initState();
    generateChartData();
  }

  void generateChartData() {
    principalSpots.clear();
    interestSpots.clear();

    for (int year = 1; year <= 15; year++) {
      double principal =
          year * 5000 + (year * 1000); // Dynamic principal calculation
      double interest =
          year * 7000 + (year * 1200); // Dynamic interest calculation

      principalSpots.add(FlSpot(year.toDouble(), principal));
      interestSpots.add(FlSpot(year.toDouble(), interest));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade100),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Yearly Payment Breakdown",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Container(
                    height: 200,
                    child: EMIChart(principalSpots, interestSpots)),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade100),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Understanding Your EMI Structure",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text(
                    "Our flexible EMI plan allows you to own your dream home with manageable monthly payments spread over 15 years."),
                SizedBox(height: 10),
                _buildBenefit("Balanced Payment Structure",
                    "Equal monthly installments ensuring consistent budget planning"),
                _buildBenefit("Reducing Interest",
                    "As you pay more principal, your interest component decreases yearly"),
                _buildBenefit("Flexible Tenure",
                    "Option to choose between 10-20 years repayment period"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefit(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 4),
        Text(description,
            style: TextStyle(fontSize: 14, color: Colors.grey[700])),
      ],
    );
  }
}

class EMIChart extends StatelessWidget {
  final List<FlSpot> principalSpots;
  final List<FlSpot> interestSpots;

  EMIChart(this.principalSpots, this.interestSpots);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: principalSpots,
            isCurved: true,
            color: Colors.blue,
            barWidth: 4,
            isStrokeCapRound: true,
            belowBarData:
                BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: interestSpots,
            isCurved: true,
            color: Colors.red,
            barWidth: 4,
            isStrokeCapRound: true,
            belowBarData:
                BarAreaData(show: true, color: Colors.red.withOpacity(0.3)),
            dotData: FlDotData(show: false),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                return LineTooltipItem(
                  '${spot.y.toStringAsFixed(2)}',
                  const TextStyle(color: Colors.white),
                );
              }).toList();
            },
          ),
          touchCallback:
              (FlTouchEvent event, LineTouchResponse? touchResponse) {},
          handleBuiltInTouches: true,
        ),
      ),
    );
  }
}
