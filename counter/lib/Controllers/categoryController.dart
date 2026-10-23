import 'dart:developer';

import 'package:counter/dataBaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{

    final List<Map<String, dynamic>> categoryList = <Map<String, dynamic>>[].obs;

  var selectCategory = ''.obs;

List<MaterialColor> lightColors = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
].obs;

  @override
  void onInit(){
    super.onInit();
    loadData();
  }

  Future<void> loadData() async{
    // 1. Fetch from database into a local variable with a distinct name
    final fetchedData = await DatabaseHelper.instance.getCategories();
    
    log('${fetchedData.length}');

    // 2. Convert sqflite's read-only result into a mutable list
    final mutableList = fetchedData.map((e) => Map<String, dynamic>.from(e)).toList();

    // 3. Assign the mutable list to your controller's reactive categoryList
    categoryList.assignAll(mutableList);
  }

  Future<void> updateCategoryExpenses({required int id , required double expenses})async{
      await DatabaseHelper.instance.updateCategoryExpense(id, expenses);
        loadData();
  }


}