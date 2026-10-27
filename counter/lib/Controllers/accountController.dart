



import 'package:counter/dataBaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AccountController extends GetxController{
    List<Map<String,dynamic>> accountList = <Map<String,dynamic>>[].obs;



   final selectContainer = ''.obs;


  List<MaterialColor> lightColors = [
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
   Colors.pink,
].obs;


   Future<void> loadData(int userId) async {
    final myAccount = await DatabaseHelper.instance.getAccounts(userId);
    accountList.assignAll(myAccount);
  }

  Future<void> insertDbAccount(int userId)async{
    await DatabaseHelper.instance.insertDB(userId);
  }

  Future<void> addAccount(String name, String balance , int iconCode , int userId) async{
      await DatabaseHelper.instance.insertAccount({
          'name':name,
          'balance':balance,
          'iconCode':iconCode,
          'userId': userId
      });
  }

    Future<void> deleteAccount(int id)async{
      await DatabaseHelper.instance.deleteAccount(id);
    }

    Future<void> updateAccount(Map<String,dynamic> account)async{
         await DatabaseHelper.instance.updateAccount(account);
    }  

    Future<void> updateAccountBalance(int id , double expense , String categoryName , int userId)async{
      final account = accountList.firstWhere((account) => account['id'] == id);
      if(expense <= account['balance'] && categoryName != 'Salary'){
        double newbalance = (account['balance'] - expense);
        await DatabaseHelper.instance.updateAccountBalance(id, newbalance ,userId);
      }else{
          double newbalance = (account['balance'] + expense);
         await DatabaseHelper.instance.updateAccountBalance(id, newbalance , userId);
      }
    }
}