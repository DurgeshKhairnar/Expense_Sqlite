
import 'package:counter/Controllers/categoryController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Categories extends StatefulWidget{
    const Categories({super.key});

    @override
    State<Categories> createState() => _Categories();
}


class _Categories extends State<Categories>{

    final CategoryController categoryController = Get.find<CategoryController>();

    @override
    Widget build(BuildContext context){
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
                  'Add Categories',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              const SizedBox(height: 10),
              Obx(() => _addAccountList(categoryController)),
            ]
          )
        )
      )   
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

}