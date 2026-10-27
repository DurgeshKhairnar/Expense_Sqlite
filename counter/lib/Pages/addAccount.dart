import 'dart:developer';

import 'package:counter/Controllers/accountController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPage();
}

class _AccountPage extends State<AccountPage> {
  final box = GetStorage();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _accountBalanceController =
      TextEditingController();

  final iconList = <IconData>[
    Icons.account_balance,
    Icons.savings,
    Icons.credit_card,
    Icons.wallet,
  ];

  IconData? containerIcon;

  List<MaterialColor> lightColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
  ];

  @override
  Widget build(BuildContext context) {
    final AccountController controller = Get.put(AccountController());
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
              Obx(() => _addAccountList(controller)),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () => _addAccountPop(controller,null),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        child: Text('Add Account', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void _addAccountPop(AccountController controller , int? id) {
    if(id != null){
        final account = controller.accountList.firstWhere((item) => item['id'] == id);
         _accountNameController.text = account['name'];
         _accountBalanceController.text = account['balance'].toString();
         containerIcon =  IconData(account['iconCode'],fontFamily:'MaterialIcons');
      }else {
        _accountNameController.text = '';
        _accountBalanceController.text = '';
    }
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
            backgroundColor: Colors.white,
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
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _accountBalanceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Account Balance',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Choose Icon',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: iconList.map((iconWidget) {
                      Color backgroundColor = (containerIcon == iconWidget)
                          ? Colors.purple[100]!
                          : Colors.indigo[50]!;
                      return GestureDetector(
                        onTap: () {
                          setDialogState(() {
                            containerIcon = iconWidget;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: backgroundColor,
                            child: Icon(iconWidget),
                          ),
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
                  int? userId = box.read('userId');
                  log('userId = $userId');
                    if(id != null){
                        controller.updateAccount({
                          'id': id,
                          'name': _accountNameController.text.trim(),
                          'balance':_accountBalanceController.text.trim(),
                          'iconCode': containerIcon!.codePoint,
                          'userId': userId 
                        });
                    }else{
                        if (_accountNameController.text != '' &&
                      _accountBalanceController.text != '' &&
                      containerIcon != null) {
                    controller.addAccount(
                      _accountNameController.text.trim(),
                      _accountBalanceController.text.trim(),
                        containerIcon!.codePoint ,  userId!);
                      }
                    }
                    controller.loadData(userId!);
                    _accountNameController.clear();
                    _accountBalanceController.clear();
                    containerIcon = null;
                    Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Add'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _addAccountList(AccountController controller) {
    return Flexible(
      child: ListView.builder(
        itemCount: controller.accountList.length,
        itemBuilder: (context, index) {
          final account = controller.accountList[index];
          final icon = IconData(
            controller.accountList[index]['iconCode'],
            fontFamily: 'MaterialIcons',
          );
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(color: Colors.white),
            child: Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                       _addAccountPop(controller,account['id']);
                    },
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                        final userId = box.read('userId');
                        controller.deleteAccount(account['id']);
                        controller.loadData(userId);
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 24,
                  backgroundColor:
                      lightColors[index % lightColors.length][100]!,
                  child: Icon(
                    icon,
                    color: lightColors[index % lightColors.length],
                  ),
                ),
                title: Text(
                  account['name'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                trailing: Text(
                  '₹${account["balance"]}.00',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
