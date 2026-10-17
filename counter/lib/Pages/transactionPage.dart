import 'package:flutter/material.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _Transaction();
}

class _Transaction extends State<Transaction> {
  String transactionString = 'All';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 249),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Transactions',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              const SizedBox(height: 10),
              transactionHeders(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget transactionHeders(){
    return   Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ['All', 'Income', 'Expense'].map((title) {
                    Color color = (transactionString == title) ? Colors.deepPurpleAccent : Colors.white;
                    return GestureDetector(
                      onTap:(){
                           setState((){
                               transactionString = title;
                           });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 8,
                        ),
                        decoration:BoxDecoration(
                            color:color,
                            borderRadius:BorderRadius.circular(30)
                        ),
                        child: Text(
                          title,
                          style: TextStyle(fontWeight: FontWeight.bold,color:(transactionString == title) ? Colors.white : Colors.black),
                        ),
                      ),
                    );
                  }).toList(), 
                ),
              );
            
  }

}
