import 'package:counter/Controllers/categoryController.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseCategoryChart extends StatelessWidget {
  const ExpenseCategoryChart({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController =
        Get.find<CategoryController>();
    return Container(
      height: 220,
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
  
          Expanded(
            flex: 1,
            child: Obx(() {
              return PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 30,
                sections: categoryController.categoryList.map((item) {
                  final double amount = item['expense'] ?? 0.0;
                  final Color color = Color(item['color'] ?? Colors.blue.value);
                  return PieChartSectionData(
                    color: color,
                    value: amount,
                    title: '₹${amount.toInt()}',
                    radius: 55,
                    titleStyle: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }).toList(),
              ),
            );
            })
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: categoryController.categoryList.map((item) {
                  final Color color = Color(item['color'] ?? Colors.blue.value);
                  final String name = item['name'] ?? '';
                  return _ChartIndicator(color: color, text: name);
                }).toList(),
              ),
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

  const _ChartIndicator({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
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
