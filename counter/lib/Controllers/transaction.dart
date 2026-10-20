
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController{
  
  List<Map<String,dynamic>> addExpenses = <Map<String,dynamic>>[].obs;

  var accountName = ''.obs;
  var icon = Icons.add.obs;
  var expenses = ''.obs;
  var categoryName = ''.obs;

}