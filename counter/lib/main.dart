import 'dart:developer';
import 'package:counter/Controllers/accountController.dart';
import 'package:counter/Controllers/authController.dart';
import 'package:counter/Controllers/categoryController.dart';
import 'package:counter/Controllers/transaction.dart';
import 'package:counter/router/pages.dart';
import 'package:counter/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //  Get.put(FinanceController());
   Get.put(AuthController());
   Get.put(AccountController());
   Get.put(CategoryController());
   Get.put(TransactionController());
  await GetStorage.init();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
      final box = GetStorage();
      bool isLogin = box.read('isLogin') ?? false;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute:isLogin ? Routes.navigation : Routes.loginScreen,
      getPages : AppPages.router
    );
  }
}

