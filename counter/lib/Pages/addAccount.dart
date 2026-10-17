import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPage();
}

class _AccountPage extends State<AccountPage> {
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _accountBalanceController =
      TextEditingController();

  final iconList = <Widget>[
    Icon(Icons.account_balance),
    Icon(Icons.savings),
    Icon(Icons.credit_card),
    Icon(Icons.wallet),
  ];

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
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Add Account',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: _addAccountPop,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        child: Text('Add Account', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void _addAccountPop() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor:Colors.white,
        title: const Text(
          'Add Account',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              TextField(
                controller: _accountNameController,
                decoration: const InputDecoration(
                  hintText: 'Account Name',
                  border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _accountBalanceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Account Balance',
                  border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Choose Icon',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 10),
              
              // Replaced ListView.builder with a Row/Wrap to prevent sizing crashes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: iconList.map((iconWidget) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.indigo[50],
                      child: iconWidget,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add your save logic here
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}
}
