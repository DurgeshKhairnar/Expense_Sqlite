import 'package:counter/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {

      final box = GetStorage();
      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 249),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             _profileHeader(),
             _customRow(),
             const SizedBox(height:10),
             _customColumn()
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileHeader() {
    return ListTile(
      title: const Text(
        'Setting',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      subtitle: const Text(
        'Manage your account and settings',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _customeListTile(Icon icon,String title,String number,Color bgColor) {
    return Column(
      mainAxisAlignment:MainAxisAlignment.center,
      crossAxisAlignment:CrossAxisAlignment.center,
      children: [
       CircleAvatar(
          backgroundColor:bgColor,
          radius: 25,
          child:icon,
        ),
        const SizedBox(height: 10),
         Text(
          title,
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
         Text(
          number,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _customRow(){
    return Container(
      padding:EdgeInsets.all(10),
      decoration:BoxDecoration(
        color:Colors.white,
        borderRadius:BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceAround,
        children: [
        _customeListTile(Icon(Icons.wallet,color:Colors.purple,),'Total Expenses','₹ 100.00',Colors.purple.shade100),
        _customeListTile(Icon(Icons.calendar_month,color:Colors.blue,),'This Month','₹ 100.00',Colors.blue.shade100),
        _customeListTile(Icon(Icons.analytics,color:Colors.green,),'Transaction','12',Colors.green.shade100),
      ],),
    );
  }

  Widget _features(Icon icon,Color bgColor,String title,String subtitle , VoidCallback onPressed){
    return ListTile(
                leading: CircleAvatar(
                  backgroundColor:bgColor,
                  radius: 25, 
                  child:icon,
                ),
                title:Text(title,  style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle:Text(subtitle,  style: TextStyle(color:Colors.grey,fontSize:15,fontWeight:FontWeight.w500)
             ),
             trailing:IconButton(
              onPressed:onPressed,
              icon:Icon(Icons.keyboard_arrow_right))
             );
  }

  Widget _customColumn(){
    return Container(
      padding:EdgeInsets.all(10),
      decoration:BoxDecoration(
        color:Colors.white,
        borderRadius:BorderRadius.circular(10),
      ),
      child: Column(children: [
          _features(Icon(Icons.money,color:Colors.pink),Colors.pink.shade100,'Monthly Budget','set your monthly budget',gotoMonthlyBudgetScreen),
          _features(Icon(Icons.question_mark,color:Colors.orange),Colors.orange.shade100,'About App','Version 1.0.0',logOut),
          _features(Icon(Icons.logout,color:Colors.red),Colors.red.shade100,'Logout','Sign in from your account',logOut)
    ],));
  }

  void logOut()async{
      await box.write('isLogin', false);
      Get.toNamed(Routes.loginScreen);
  }

  void gotoMonthlyBudgetScreen(){
       Get.toNamed(Routes.monthlyBudget);
  }

}
