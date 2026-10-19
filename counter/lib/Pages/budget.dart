import 'package:counter/Widget/sectionHeders.dart';
import 'package:counter/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPage();
}

class _BudgetPage extends State<BudgetPage> {
  final List<Map<String, dynamic>> categoryList = [
    {
      'name': 'Shopping',
      'icon': Icons.shopping_bag,
      'color': Colors.pink,
      'expense': 0.0,
    },
    {
      'name': 'Food & Dining',
      'icon': Icons.restaurant,
      'color': Colors.orange,
      'expense': 0.0,
    },
    {
      'name': 'Transport',
      'icon': Icons.directions_car,
      'color': Colors.blue,
      'expense': 0.0,
    },
    {
      'name': 'Bills',
      'icon': Icons.receipt_long,
      'color': Colors.red,
      'expense': 0.0,
    },
    {
      'name': 'Mobile Recharge',
      'icon': Icons.phone_android,
      'color': Colors.purple,
      'expense': 0.0,
    },
    {
      'name': 'Entertainment',
      'icon': Icons.movie,
      'color': Colors.deepPurple,
      'expense': 0.0,
    },
    {
      'name': 'Salary',
      'icon': Icons.account_balance_wallet,
      'color': Colors.green,
      'expense': 0.0,
    },
    {
      'name': 'Grocery Store',
      'icon': Icons.local_grocery_store,
      'color': Colors.teal,
      'expense': 0.0,
    },
    {
      'name': 'Tea & Coffee',
      'icon': Icons.coffee,
      'color': Colors.brown,
      'expense': 0.0,
    },
  ];

  @override
  Widget build(BuildContext conetxt) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 249),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Budget',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              const SizedBox(height: 10),
              monthlyBudgetContainer(),
              SectionHeader(
                title: 'Categories',
                onSeeAllPressed: () => Get.toNamed(Routes.addCategories),
              ),
              const SizedBox(height: 5),
               _addAccountList()
            ],
          ),
        ),
      ),
    );
  }

  Widget _addAccountList() {
    return Flexible(
      child: ListView.builder(
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(color: Colors.white),
            child: ListTile(
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: categoryList[index]['color'][100]!,
                child: Icon(
                  categoryList[index]['icon'],
                  color: categoryList[index]['color'][800],
                ),
              ),
              title: Text(
                categoryList[index]['name'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              trailing: Text(
                '₹${categoryList[index]["expense"]}.00'.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget monthlyBudgetContainer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Monthly Budget',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Spent',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹250.00',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Text(
                  '₹100.00',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 10,
                child: LinearProgressIndicator(
                  value: 0.65, // Value between 0.0 and 1.0
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Colors.deepPurple,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '75% of budget used',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
