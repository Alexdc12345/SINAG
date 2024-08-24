import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class test_chart extends StatelessWidget {
  const test_chart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: true), // Removed const from here
        titlesData: const FlTitlesData(show: true), // Removed const from here
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 1), // Removed const from here
              const FlSpot(1, 1.5), // Removed const from here
              const FlSpot(2, 1.4), // Removed const from here
              const FlSpot(3, 3.4), // Removed const from here
              const FlSpot(4, 2), // Removed const from here
              const FlSpot(5, 2.2), // Removed const from here
              const FlSpot(6, 1.8), // Removed const from here
            ],
            isCurved: true,
            color: Colors.blue,
            barWidth: 4,
            belowBarData: BarAreaData(show: false),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: const LineTouchTooltipData(
            getTooltipColor: defaultLineTooltipColor
          ),
          touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
            if (!event.isInterestedForInteractions || response == null || response.lineBarSpots == null) {
              return;
            }
            // Handle touch events here
          },
          handleBuiltInTouches: true,
        ),
      ),
    );
  }
}
