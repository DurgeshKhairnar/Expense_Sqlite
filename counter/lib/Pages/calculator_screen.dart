import 'package:counter/Controllers/accountController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculate extends StatefulWidget {
  const Calculate({super.key});

  @override
  State<Calculate> createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
  String expression = '';

  final List<String> buttons = [
    'C',
    '()',
    '%',
    '/',
    '⌫',
    '7',
    '8',
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Align(
                  alignment:Alignment.centerLeft,
                  child: Text('Select Account',style:TextStyle(fontWeight:FontWeight.bold))),
                accountList(accountController),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
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
                      style: const TextStyle(fontSize: 36, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 390,
                  child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1.3,
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
                Container(
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget accountList(AccountController accountController) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: accountController.accountList.length,
        itemBuilder: (context, index) {
          final account = accountController.accountList[index];
          return Container(
            height: 30,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:20, vertical:5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(account['icon'], color: Colors.red[800]),
                  const SizedBox(height: 5),
                  Text(
                    account['name'],
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15,fontWeight:FontWeight.bold),
                  ),
                  Text(
                    '₹${account["balance"]}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
