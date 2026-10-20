import 'dart:developer';

import 'package:counter/Controllers/transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _Transaction();
}

class _Transaction extends State<Transaction> {
  String transactionString = 'All';
  @override
  Widget build(BuildContext context) {
    final TransactionController transactionController =
        Get.find<TransactionController>();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 249),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Transactions',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              const SizedBox(height: 10),
              transactionHeders(),
              const SizedBox(height: 10),
              Flexible(
                child: Obx(() {
                  final addExpensesList = transactionController.addExpenses;
                  return (addExpensesList.isEmpty) ? Text('List is Empty') : ListView.builder(
                    itemCount: addExpensesList.length,
                    itemBuilder: (context, index) {
                      log('₹${addExpensesList[index]["expenses"]}');
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(color: Colors.white),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 24,
                            // backgroundColor:Colors.blue[300],
                            child: Icon(
                              addExpensesList[index]['icon'],
                              color: Colors.blue[300],
                            ),
                          ),
                          title: Text(
                            addExpensesList[index]['categoryName'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            addExpensesList[index]['accountName'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          trailing: Text(
                            '₹${addExpensesList[index]["expenses"]}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget transactionHeders() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ['All', 'Income', 'Expense'].map((title) {
          Color color = (transactionString == title)
              ? Colors.deepPurpleAccent
              : Colors.white;
          return GestureDetector(
            onTap: () {
              setState(() {
                transactionString = title;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: (transactionString == title)
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
