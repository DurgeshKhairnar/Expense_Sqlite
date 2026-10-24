import 'package:counter/Navigation/customNavBar.dart';
import 'package:counter/Pages/budget.dart';
import 'package:counter/Pages/homePages.dart';
import 'package:counter/Pages/profile_page.dart';
import 'package:counter/Pages/transactionPage.dart';
import 'package:counter/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _currentIndex = 0;


  final List<Widget> _screens = [
    const MyHomePage(),         
    const Transaction(),    
    const BudgetPage(),        
    const ProfilePage(),       
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      

      floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        onAddPressed: () => Get.toNamed(Routes.calculatorScreen),
      ),
    );
  }
}