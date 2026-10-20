import 'dart:developer';

import 'package:counter/dataBaseHelper.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{

    final List<Map<String, dynamic>> categoryList = <Map<String, dynamic>>[].obs;

  var selectCategory = ''.obs;


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
}