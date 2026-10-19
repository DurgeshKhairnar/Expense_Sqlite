
import 'package:flutter/material.dart';

class Categories extends StatefulWidget{
    const Categories({super.key});

    @override
    State<Categories> createState() => _Categories();
}


class _Categories extends State<Categories>{

final List<Map<String, dynamic>> categoryList = [
  {
    'name': 'Shopping',
    'icon': Icons.shopping_bag,
    'color': Colors.pink,
    'expense': 0.0,
  },
  {
    'name': 'Food & Dining',
    'icon': Icons.restaurant,
    'color': Colors.orange,
    'expense': 0.0,
  },
  {
    'name': 'Transport',
    'icon': Icons.directions_car,
    'color': Colors.blue,
    'expense': 0.0,
  },
  {
    'name': 'Bills',
    'icon': Icons.receipt_long,
    'color': Colors.red,
    'expense': 0.0,
  },
  {
    'name': 'Mobile Recharge',
    'icon': Icons.phone_android,
    'color': Colors.purple,
    'expense': 0.0,
  },
  {
    'name': 'Entertainment',
    'icon': Icons.movie,
    'color': Colors.deepPurple,
    'expense': 0.0,
  },
  {
    'name': 'Salary',
    'icon': Icons.account_balance_wallet,
    'color': Colors.green,
    'expense': 0.0,
  },
  {
    'name': 'Grocery Store',
    'icon': Icons.local_grocery_store,
    'color': Colors.teal,
    'expense': 0.0,
  },
  {
    'name': 'Tea & Coffee',
    'icon': Icons.coffee,
    'color': Colors.brown,
    'expense': 0.0,
  },
];

    @override
    Widget build(BuildContext context){
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 249, 249, 249),
          body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [ 
               const SizedBox(height: 10),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Add Categories',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              const SizedBox(height: 10),
              _addAccountList(),
            ]
          )
        )
      )   
    );
  }
    Widget _addAccountList() {
   return Flexible(
      child: ListView.builder(
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(color: Colors.white),
            child: ListTile(
              leading: CircleAvatar(
                radius: 24,
                backgroundColor:categoryList[index]['color'][100]!,
                child: Icon(
                  categoryList[index]['icon'],
                  color: categoryList[index]['color'][800],
                ),
              ),
              title: Text(
                categoryList[index]['name'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              trailing: Text(
                '₹${categoryList[index]["expense"]}.00'.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}