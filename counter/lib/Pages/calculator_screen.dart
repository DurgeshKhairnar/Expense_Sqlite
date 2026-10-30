import 'dart:developer';

import 'package:counter/Controllers/accountController.dart';
import 'package:counter/Controllers/categoryController.dart';
import 'package:counter/Controllers/transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculate extends StatefulWidget {
  const Calculate({super.key});

  @override
  State<Calculate> createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
  final box = GetStorage();
  String expression = '';

  final TextEditingController note = TextEditingController();

  final List<String> buttons = [
    'C',
    '()',
    '%',
    '/',
    '⌫',
    '7',
    '8',
    '9',
    'X',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    '=',
  ];

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        expression = '';
      } else if (value == '⌫') {
        if (expression == 'Error') {
          expression = '';
        } else if (expression.isNotEmpty) {
          expression = expression.substring(0, expression.length - 1);
        }
      } else if (value == '=') {
        calculateResult();
      } else if (value == '()') {
        addParenthesis();
      } else if (value == '%') {
        addPercentage();
      } else {
        if (expression == 'Error') {
          expression = '';
        }

        if (value == '.') {
          final lastNumber = RegExp(
            r'\d*\.?\d*$',
          ).firstMatch(expression)?.group(0);

          if (lastNumber != null && lastNumber.contains('.')) {
            return;
          }
        }

        expression += value;
      }
    });
  }

  void addParenthesis() {
    if (expression == 'Error') {
      expression = '';
    }

    final openCount = '('.allMatches(expression).length;
    final closeCount = ')'.allMatches(expression).length;

    if (openCount > closeCount) {
      expression += ')';
    } else {
      expression += '(';
    }
  }

  void addPercentage() {
    if (expression.isEmpty || expression == 'Error') {
      return;
    }

    final match = RegExp(r'\d+\.?\d*$').firstMatch(expression);

    if (match != null) {
      final number = match.group(0)!;

      expression = expression.replaceRange(
        match.start,
        match.end,
        '($number/100)',
      );
    } else if (expression.endsWith(')')) {
      expression += '/100';
    }
  }

  void calculateResult() {
    if (expression.isEmpty || expression == 'Error') {
      return;
    }

    try {
      final input = expression.replaceAll('X', '*');

      final parser = Parser();
      final parsedExpression = parser.parse(input);

      final context = ContextModel();

      final result = parsedExpression.evaluate(EvaluationType.REAL, context);

      if (!result.isFinite) {
        expression = 'Error';
        return;
      }

      expression = formatResult(result);
    } catch (_) {
      expression = 'Error';
    }
  }

  String formatResult(double result) {
    if (result == result.truncateToDouble()) {
      return result.toInt().toString();
    }

    return result.toStringAsPrecision(10);
  }

  @override
  Widget build(BuildContext context) {
    final AccountController accountController = Get.find<AccountController>();
    final CategoryController categoryController =
        Get.find<CategoryController>();
    final TransactionController transactionController =
        Get.find<TransactionController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select Account',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                accountList(accountController, transactionController),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select Category',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                categoryList(categoryController, transactionController),
                const SizedBox(height: 3),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: note,
                      decoration: InputDecoration(
                        hintText: 'Add Note (optional)',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(
                      expression.isEmpty ? '0' : expression,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 350,
                  child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1.4,
                        ),
                    itemBuilder: (context, index) {
                      final value = buttons[index];

                      final isOperator = [
                        '/',
                        'X',
                        '-',
                        '+',
                        '%',
                        '=',
                        '()',
                        'C',
                        '⌫',
                      ].contains(value);

                      return ElevatedButton(
                        onPressed: () => onButtonPressed(value),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: value == '='
                              ? Colors.green
                              : isOperator
                              ? Colors.grey.shade300
                              : Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          side: const BorderSide(color: Colors.black12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: FittedBox(
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _addExpensesMethod(
                      transactionController,
                      accountController,
                      categoryController,
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Add Expenses',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addExpensesMethod(
    TransactionController transactionController,
    AccountController accountController,
    CategoryController categoryController,
  ) {
     int? userId = box.read('userId');
    transactionController.addExpense(
      title: transactionController.title.toString(),
      amount: double.tryParse(expression) ?? 0,
      date: DateTime.now().toIso8601String(),
      iconCode: transactionController.iconCode.value,
      accountId: transactionController.accountId.value,
      categoryId: transactionController.categoryId.value, userId: userId!,
    );
    accountController.updateAccountBalance(
      transactionController.accountId.value,
      double.tryParse(expression) ?? 0,
      categoryController.selectCategory.value,
      userId
    );
    categoryController.updateCategoryExpenses(
      id: transactionController.categoryId.value,
      expenses: double.tryParse(expression) ?? 0,
      userId : userId
    );
    accountController.selectContainer.value = '';
    categoryController.selectCategory.value = '';
    expression = '0';
    transactionController.loadData(userId);
    categoryController.loadData(userId);
    accountController.loadData(userId);
     Get.back();
  }

  Widget accountList(
    AccountController accountController,
    TransactionController transactionController,
  ) {
    return SizedBox(
      height: 90,
      child: Obx(() {
        final selectedName = accountController.selectContainer.value;
        final totalAccounts = accountController.accountList.length;

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: totalAccounts,
          itemBuilder: (context, index) {
            final account = accountController.accountList[index];
            final isSelected = selectedName == account['name'];
            final icon = IconData(
              account['iconCode'],
              fontFamily: 'MaterialIcons',
            );

            final borderColor = isSelected ? Colors.blue : Colors.grey.shade300;

            return GestureDetector(
              onTap: () {
                accountController.selectContainer.value = account['name'];
                transactionController.accountId.value = account['id'] as int;
              },
              child: Container(
                height: 25,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: borderColor,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 3,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, color: Colors.red[800]),
                      const SizedBox(height: 3),
                      Text(
                        account['name'].toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '₹${account["balance"]}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget categoryList(
    CategoryController categoryController,
    TransactionController transactionController,
  ) {
    return SizedBox(
      height: 90,
      child: Obx(() {
        final categoryList = categoryController.categoryList;
        final selectName = categoryController.selectCategory.value;
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            final category = categoryList[index];
            final isSelected = (selectName == category['name']);
            final borderColor = isSelected ? Colors.blue : Colors.grey.shade300;
            final int iconCode =
                category['iconCode'] ?? Icons.category.codePoint;
            final iconData = IconData(iconCode, fontFamily: 'MaterialIcons');
            final int colorValue = category['color'] ?? Colors.blue.value;
            final Color categoryColor = Color(colorValue);
            return GestureDetector(
              onTap: () {
                log(' express on == $expression');
                categoryController.selectCategory.value = category['name'];
                transactionController.categoryId.value = category['id'] as int;
                transactionController.iconCode.value = iconCode;
              },
              child: Container(
                height: 25,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: borderColor,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 3,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(iconData, color: categoryColor),
                      const SizedBox(height: 3),
                      Text(
                        category['name'],
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
