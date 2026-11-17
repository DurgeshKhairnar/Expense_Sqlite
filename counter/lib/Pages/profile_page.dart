import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 249),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_profileHeader(),
             _customRow() 
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileHeader() {
    return ListTile(
      title: const Text(
        'Profile',
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
    return Row(
      mainAxisAlignment:MainAxisAlignment.spaceAround,
      children: [
      _customeListTile(Icon(Icons.wallet,color:Colors.purple,),'Total Expenses','₹ 100.00',Colors.purple.shade100),
      _customeListTile(Icon(Icons.calendar_month,color:Colors.blue,),'This Month','₹ 100.00',Colors.blue.shade100),
      _customeListTile(Icon(Icons.wallet,color:Colors.green,),'Transaction','₹ 100.00',Colors.green.shade100),
    ],);
  }

}
