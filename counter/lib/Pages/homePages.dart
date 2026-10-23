import 'dart:ui';

import 'package:counter/Controllers/accountController.dart';
import 'package:counter/Widget/expensesCategoryChart.dart';
import 'package:counter/Widget/sectionHeders.dart';
import 'package:counter/dataBaseHelper.dart';
import 'package:counter/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    final myAccount = await DatabaseHelper.instance.getAccounts();

    setState(() {
      expenseList = myAccount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AccountController controller = Get.put(AccountController());
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
              Obx(() =>  _accountList(controller)),
              const SizedBox(height: 10),
              const Text(
                'Spending Overview',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

  Widget _totalExpensesContainer() {
    return Container(
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Total Expenses',
                      style: TextStyle(color: Colors.white, fontSize: 15),
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
                      child: IconButton(
                        iconSize: 30,
                        onPressed: () {},
                        icon: Icon(Icons.wallet, color: Colors.white),
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

  Widget _accountList(AccountController controller) {
     final limitedList = controller.accountList.take(3).toList();
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount:limitedList.length,
        itemBuilder: (context, index) {
          final iconData = IconData(limitedList[index]['iconCode'],fontFamily: 'MaterialIcons');
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: Colors.white),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: controller
                    .lightColors[index % controller.lightColors.length][100]!,
                child: Icon(
                  iconData,
                  color: controller
                      .lightColors[index % controller.lightColors.length],
                ),
              ),
              title: Text(
                 limitedList[index]['name'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              trailing: Text(
                '₹${limitedList[index]["balance"]}.00',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.green,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
