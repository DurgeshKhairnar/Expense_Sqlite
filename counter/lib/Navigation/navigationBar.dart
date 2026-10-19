import 'package:counter/Navigation/customNavBar.dart';
import 'package:counter/Pages/budget.dart';
import 'package:counter/Pages/homePages.dart';
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
  // Track the currently active tab index
  int _currentIndex = 0;

  // List of screens corresponding to your navigation bar tabs[cite: 1]
  final List<Widget> _screens = [
    const MyHomePage(),          // Home tab content
    const Transaction(),    // Transactions tab content
    const BudgetPage(),        // Budget tab content
    // const ProfileScreen(),       // Profile tab content
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack preserves the state of each tab when switching
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      
      // Attach your custom floating navigation bar at the bottom
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