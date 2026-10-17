import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpenseCategoryChart extends StatelessWidget {
  const ExpenseCategoryChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // 1. The Pie Chart
          Expanded(
            flex: 1,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 35,
                sections: [
                  PieChartSectionData(
                    color: Colors.deepPurple,
                    value: 45,
                    title: '45%',
                    radius: 45,
                    titleStyle: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    color: Colors.lightBlueAccent,
                    value: 30,
                    title: '30%',
                    radius: 40,
                    titleStyle: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    color: Colors.orangeAccent,
                    value: 25,
                    title: '25%',
                    radius: 40,
                    titleStyle: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(width: 16),

          // 2. Category Legend / Labels
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _ChartIndicator(
                  color: Colors.deepPurple,
                  text: 'Food & Dining',
                ),
                SizedBox(height: 10),
                _ChartIndicator(
                  color: Colors.lightBlueAccent,
                  text: 'Shopping',
                ),
                SizedBox(height: 10),
                _ChartIndicator(
                  color: Colors.orangeAccent,
                  text: 'Bills & Utilities',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widget for the legend indicators
class _ChartIndicator extends StatelessWidget {
  final Color color;
  final String text;

  const _ChartIndicator({
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}