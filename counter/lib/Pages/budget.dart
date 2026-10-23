
import 'package:counter/Controllers/categoryController.dart';
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

  @override
  Widget build(BuildContext conetxt) {
    final CategoryController categoryController = Get.find<CategoryController>();
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
                Obx(() => _addAccountList(categoryController)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addAccountList(CategoryController categoryController) {
    final categoryList = categoryController.categoryList;
    return Flexible(
      child: (categoryList.isEmpty) ?  const Text('List is Empty') : ListView.builder(
        itemCount:categoryList.length,
        itemBuilder: (context, index) {
          final category = categoryController.categoryList[index];
          final int iconCode = category['iconCode'] ?? Icons.category.codePoint;
        final iconData = IconData(iconCode, fontFamily: 'MaterialIcons');
        final int colorValue = category['color'] ?? Colors.blue.value;
        final Color categoryColor = Color(colorValue);
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(color: Colors.white),
            child: ListTile(
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: categoryColor.withOpacity(0.2),
                child: Icon(
                  iconData,
                  color: categoryColor,
                ),
              ),
              title: Text(
                category ['name'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              trailing: Text(
                '₹${category ["expense"]}.00'.toString(),
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
