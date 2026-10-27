
import 'package:counter/dataBaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CategoryController extends GetxController{

  final box = GetStorage();

  final List<Map<String, dynamic>> categoryList = <Map<String, dynamic>>[].obs;

  var selectCategory = ''.obs;

List<MaterialColor> lightColors = [
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
    Colors.pink,
].obs;

  @override
  void onInit(){
    super.onInit();
  }

  Future<void> loadData(int userId) async{

    final fetchedData = await DatabaseHelper.instance.getCategories(userId);

    final mutableList = fetchedData.map((e) => Map<String, dynamic>.from(e)).toList();

    var sortCategories = List<Map<String,dynamic>>.from(mutableList);

    sortCategories.sort((a,b){
        double aData = a['expense'] ?? 0.0;
        double bData = b['expense'] ?? 0.0;
        return bData.compareTo(aData);
    });

    categoryList.assignAll(sortCategories);
  }

  

  Future<void> updateCategoryExpenses({required int id , required double expenses , required int userId})async{
      await DatabaseHelper.instance.updateCategoryExpense(id, expenses , userId);
      //  await loadData();
  }

  Future<void> insertCategories(int id)async{
     await DatabaseHelper.instance.insertCategories(id);
    //  await loadData();
  }

}