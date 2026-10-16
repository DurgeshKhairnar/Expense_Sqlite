import 'dart:ui';

import 'package:counter/dataBaseHelper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final Api api = Api();

  List<Map<String,dynamic>> expenseList = [];

  double balance = 0;

  double todayExpenses = 0;

  TextEditingController balanceController = TextEditingController();
  TextEditingController expenceController = TextEditingController();
  TextEditingController nameController = TextEditingController();


  @override
  void initState(){
    super.initState();
    loadData();
  }

  Future<void> loadData() async{
    final totalAmount  = await DatabaseHelper.instance.getTotalExpenses();
    final MyExpenseList = await DatabaseHelper.instance.getAllExpense();
    final today = await DatabaseHelper.instance.getTodayExpenses();

    setState((){
        balance = totalAmount;
        expenseList = MyExpenseList;
        todayExpenses = today;
    });
  }

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
              const Text(
                'Hi Durgesh 👋',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.deepPurple, Colors.lightBlueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 10.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Total Balance',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 4), // Spacing between texts
                              Text(
                                '₹$balance',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            iconSize: 30,
                            onPressed: _addTotalBalance,
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Transactions $todayExpenses",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
             
              Flexible(
                child: expenseList.isEmpty ? Text('List is Empty'): ListView.builder(
                itemCount:expenseList.length,
                itemBuilder: (context,index){
                  return  ListTile(
                  leading: CircleAvatar(
                  backgroundColor: Colors.purple[100],
                  child: Icon(Icons.shopping_cart_sharp),
                ),
                title: Text(expenseList[index]['title']),
                subtitle: Text(expenseList[index]['expense_date']),
                trailing: Text(expenseList[index]['amount'],style:TextStyle(fontSize:16,color:Colors.green,fontWeight:FontWeight.bold)),
                );
              }),)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed:_addbalance,
        child: Text('Add'),
      ),
    );
  }

  void _addTotalBalance() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 5),
                Text(
                  'Add Account Balance',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: balanceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Add Account Balance',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      balance += int.tryParse(balanceController.text) ?? 0;
                    });
                    balanceController.clear();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, // Background color
                    foregroundColor: Colors.white, // Text/Icon color
                  ),
                  child: const Text('+ Add'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addbalance()async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:Text('Add Expense',style:TextStyle(
              fontSize:16,
              fontWeight:FontWeight.bold,
          ),),
          actions:[
              TextField(
                controller:nameController,
                decoration:InputDecoration(
                  hintText:'Expence Name',
                  border:OutlineInputBorder(
                    borderSide:BorderSide(width:2)
                  )
                )
              ),
              const SizedBox(height:5),
              TextField(
                controller:expenceController,
                decoration:InputDecoration(
                  hintText:'Expence Amount',
                  border:OutlineInputBorder(
                    borderSide:BorderSide(width:2)
                  )
                )
              ),
              const SizedBox(height:5),
               ElevatedButton(
                  onPressed: () async{
                             final expenses = {
                               'title': nameController.text,
                               'amount':double.tryParse(expenceController.text.trim()),
                                'expense_date': DateTime.now().toIso8601String().substring(0, 10),
                             };  
                    await DatabaseHelper.instance.addExpense(expenses);
                    await loadData();     
                    nameController.clear();
                    expenceController.clear();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, // Background color
                    foregroundColor: Colors.white, // Text/Icon color
                  ),
                  child: const Text('+ Add Expense'),
                ),
          ]
        );
      },
    );
  }
  
}
