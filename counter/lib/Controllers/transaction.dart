
import 'package:counter/dataBaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class TransactionController extends GetxController {
  List<Map<String, dynamic>> addExpensesList = <Map<String, dynamic>>[].obs;
  var selectedYearMonth = DateFormat('yyyy-MM').format(DateTime.now()).obs;

   RxString transactionString = 'All'.obs;

    final box = GetStorage();

  List<MaterialColor> lightColors = [
    Colors.red,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.pink,
  ].obs;

  var title = ''.obs;
  RxDouble amount = 0.0.obs;
  var data = ''.obs;
  RxInt accountId = 0.obs;
  RxInt categoryId = 0.obs;
  RxInt iconCode = 0.obs;


  Future<void> loadData(int id) async {
    final expenseList = await DatabaseHelper.instance.getExpenses(id);
    addExpensesList.assignAll(expenseList);

    // Optional: If you want it to jump to the latest expense month automatically:
    if (addExpensesList.isNotEmpty) {
      DateTime latestDate = addExpensesList
          .map((e) {
            return DateTime.tryParse(e['date'] ?? '') ?? DateTime(1970);
          })
          .reduce((a, b) => a.isAfter(b) ? a : b);

      selectedYearMonth.value = DateFormat('yyyy-MM').format(latestDate);
    }
  }

  Future<void> addExpense({
    required String title,
    required double amount,
    required String date,
    required int iconCode,
    required int accountId,
    required int categoryId,
    required int userId
  }) async {
    await DatabaseHelper.instance.insertExpenses({
      'title': title,
      'amount': amount,
      'date': date,
      'iconCode': iconCode,
      'accountId': accountId,
      'categoryId': categoryId,
      'userId':userId
    });
    await loadData(userId);
  }

  Future<void> deleteExpense(int id) async {
    await DatabaseHelper.instance.deleteExpense(id);
  }

  Map<String, List<Map<String, dynamic>>> get groupedTransactions {
    Map<String, List<Map<String, dynamic>>> grouped = {};

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

   

  List<Map<String, dynamic>>  filteredTransactions  = addExpensesList.where((transaction) {
      if (transactionString.value == 'All') {
       return true;
    }
    final categoryName =
        transaction['categoryName']?.toString() ?? '';

    if (transactionString.value == 'Income') {
      return categoryName == 'Salary';
    }

    if (transactionString.value == 'Expenses') {
      return categoryName != 'Salary';
    }

    return true;
  }).toList();

    var sortList = List<Map<String, dynamic>>.from(filteredTransactions);

    sortList.sort((a, b) {
      DateTime dateA = DateTime.tryParse(a['date'] ?? '') ?? DateTime(1970);
      DateTime dateB = DateTime.tryParse(b['date'] ?? '') ?? DateTime(1970);
      return dateB.compareTo(dateA);
    });

    for (var item in sortList) {
      final dateStr = item['date'] ?? '';
      if (dateStr == '') continue;

      DateTime itemDate;
      try {
        itemDate = DateTime.parse(dateStr);
      } catch (e) {
        continue;
      }

      final itemDay = DateTime(itemDate.year, itemDate.month, itemDate.day);
      String headerKey;

      if (itemDay == today) {
        headerKey = 'Today';
      } else if (itemDay == yesterday) {
        headerKey = 'Yesterday';
      } else {
        headerKey = DateFormat('dd MMM yyyy').format(itemDay);
      }
      if (!grouped.containsKey(headerKey)) {
        grouped[headerKey] = [];
      }

      grouped[headerKey]!.add(item);
    }

    grouped.removeWhere((key, value) => value.isEmpty);

    return grouped;
  }

  // Inside your TransactionController class:
  double get totalMonthExpense {
    double total = 0.0;

    // Loop through all date groups in the current month
    groupedTransactions.forEach((dateHeader, items) {
      for (var item in items) {
        // Safely parse amount as double
        final double amount = (item['amount'] is num)
            ? (item['amount'] as num).toDouble()
            : double.tryParse(item['amount'].toString()) ?? 0.0;

        total += amount;
      }
    });

    return total;
  }
}
