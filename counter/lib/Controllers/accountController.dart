



import 'package:counter/dataBaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AccountController extends GetxController{
    List<Map<String,dynamic>> accountList = <Map<String,dynamic>>[].obs;

List<MaterialColor> lightColors = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
].obs;

   final selectContainer = ''.obs;


   @override
   void onInit(){
     super.onInit();
     loadData();
   }

   Future<void> loadData() async {
    final myAccount = await DatabaseHelper.instance.getAccounts();
    accountList.assignAll(myAccount);
  }

  Future<void> insertDbAccount(int id)async{
    await DatabaseHelper.instance.insertDB(id);
    await loadData();
  }

  Future<void> addAccount(String name, String balance , int iconCode) async{
      await DatabaseHelper.instance.insertAccount({
          'name':name,
          'balance':balance,
          'iconCode':iconCode
      });
  }

    Future<void> deleteAccount(int id)async{
      await DatabaseHelper.instance.deleteAccount(id);
    }

    Future<void> updateAccount(Map<String,dynamic> account)async{
         await DatabaseHelper.instance.updateAccount(account);
    }  

    Future<void> updateAccountBalance(int id , double expense , String categoryName)async{
      final account = accountList.firstWhere((account) => account['id'] == id);
      if(expense <= account['balance'] && categoryName != 'Salary'){
        double newbalance = (account['balance'] - expense);
        await DatabaseHelper.instance.updateAccountBalance(id, newbalance);
      }else{
          double newbalance = (account['balance'] + expense);
         await DatabaseHelper.instance.updateAccountBalance(id, newbalance);
      }
      await loadData();
    }
}