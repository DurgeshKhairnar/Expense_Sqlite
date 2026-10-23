
import 'package:counter/Controllers/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
    // 1. Get the grouped map from the controller
    final groupedData = transactionController.groupedTransactions;
    final dateKeys = groupedData.keys.toList();

    return (groupedData.isEmpty)
        ? const Center(child: Text('List is Empty'))
        : ListView.builder(
            itemCount: dateKeys.length,
            itemBuilder: (context, sectionIndex) {
              final dateHeader = dateKeys[sectionIndex];
              final itemsInGroup = groupedData[dateHeader]!;
            
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Date Section Header ("Today", "Yesterday", etc.) ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Text(
                      dateHeader,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  // --- List of Items under this Date Header ---
                  ...itemsInGroup.map((expense) {
                    // Find original index or handle properties safely from map item
                    final icon = IconData(
                      expense['iconCode'] ?? 58778,
                      fontFamily: 'MaterialIcons',
                    );
                    
                    final rawDate = expense['date'] ?? '';
                    String date = '';
                    if (rawDate.isNotEmpty) {
                      DateTime parseDate = DateTime.parse(rawDate);
                      date = DateFormat('MMM d, yyyy').format(parseDate);
                    }

                    // Use a fallback index for color cycling if needed
                    int colorIndex = expense['id'] ?? 0;

                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              // Edit action code here
                            },
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              transactionController.deleteExpense(expense['id']);
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: transactionController
                                .lightColors[colorIndex %
                                    transactionController.lightColors.length][100],
                            radius: 24,
                            child: Icon(
                              icon,
                              color: transactionController
                                  .lightColors[colorIndex %
                                      transactionController.lightColors.length],
                            ),
                          ),
                          title: Text(
                            expense['categoryName'] ?? 'Expense',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            "$date • ${expense['accountName'] ?? ''}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                          trailing: Text(
                            '- ₹${expense["amount"]}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
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
