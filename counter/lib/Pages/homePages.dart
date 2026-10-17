import 'dart:ui';

import 'package:counter/Widget/expensesCategoryChart.dart';
import 'package:counter/Widget/sectionHeders.dart';
import 'package:counter/dataBaseHelper.dart';
import 'package:counter/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final Api api = Api();

  List<Map<String, dynamic>> expenseList = [];

  double balance = 0;

  double todayExpenses = 0;

  TextEditingController balanceController = TextEditingController();
  TextEditingController expenceController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // loadData();
  }

  Future<void> loadData() async {
    final totalAmount = await DatabaseHelper.instance.getTotalExpenses();
    final MyExpenseList = await DatabaseHelper.instance.getAllExpense();
    final today = await DatabaseHelper.instance.getTodayExpenses();

    setState(() {
      balance = totalAmount;
      expenseList = MyExpenseList;
      todayExpenses = today;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 249),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _heders(),
              const SizedBox(height: 10),
              _totalExpensesContainer(),
             const SizedBox(height: 10),
              SectionHeader(
                title: 'Accounts',
                onSeeAllPressed: () => Get.toNamed(Routes.addAccount),
              ),
              const SizedBox(height: 5),
              _accountList(),
              const SizedBox(height: 10),
              const  Text(
                'Spending Overview',
                style:TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ExpenseCategoryChart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _heders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Good Morning',
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
        const Text(
          'Hi Durgesh 👋',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _totalExpensesContainer(){
    return   Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.deepPurple, Colors.lightBlueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 10.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Total Expenses',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 4), // Spacing between texts
                              Text(
                                '₹$balance',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.deepPurple,
                                  Colors.lightBlueAccent,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 5.0,
                                  sigmaY: 10.0,
                                ),
                                child: IconButton(
                                  iconSize: 30,
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.wallet,
                                    color: Colors.white,
                                  ),
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

  Widget _accountList(){
    return   Container(
                width:MediaQuery.of(context).size.width,
                // height:50,
                decoration:BoxDecoration(
                  color:Colors.white,
                  borderRadius:BorderRadius.circular(5),
                ),
                child:Column(children: [
                  ListTile(
                  leading:CircleAvatar(
                    child:Icon(Icons.wallet)
                  ),
                  title:const Text('Main Account',style:TextStyle(fontWeight:FontWeight.bold)),
                  trailing: const Text('₹120.00'),
                ),
                ListTile(
                  leading:CircleAvatar(
                    child:Icon(Icons.wallet)
                  ),
                  title:const Text('Main Account',style:TextStyle(fontWeight:FontWeight.bold)),
                  trailing: const Text('₹120.00'),
                ),
                 ListTile(
                  leading:CircleAvatar(
                    child:Icon(Icons.wallet)
                  ),
                  title:const Text('Main Account',style:TextStyle(fontWeight:FontWeight.bold)),
                  trailing: const Text('₹120.00'),
                )
                ],)
              );
           
  }

}
