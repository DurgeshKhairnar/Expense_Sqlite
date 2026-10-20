import 'package:counter/Controllers/categoryController.dart';
import 'package:counter/Controllers/transaction.dart';
import 'package:counter/router/pages.dart';
import 'package:counter/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
   Get.put(CategoryController());
   Get.put(TransactionController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute:Routes.navigation,
      getPages : AppPages.router
    );
  }
}

