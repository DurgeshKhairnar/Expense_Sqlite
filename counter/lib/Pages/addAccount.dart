
import 'package:counter/Controllers/accountController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPage();
}

class _AccountPage extends State<AccountPage> {
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
             Obx(() =>_addAccountList(controller)),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () => _addAccountPop(controller),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        child: Text('Add Account', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void _addAccountPop(AccountController controller) {
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
                  if (_accountNameController.text != '' &&
                      _accountBalanceController.text != '' &&
                      containerIcon != null) {
                    controller.accountList.add({
                      'icon': containerIcon,
                      'name': _accountNameController.text.trim(),
                      'balance': _accountBalanceController.text.trim(),
                    });
                    _accountNameController.clear();
                    _accountBalanceController.clear();
                    containerIcon = null;
                    Navigator.pop(context);
                  }
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
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(color: Colors.white),
            child: ListTile(
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: lightColors[index % lightColors.length][100]!,
                child: Icon(
                  controller.accountList[index]['icon'],
                  color: lightColors[index % lightColors.length],
                ),
              ),
              title: Text(
                controller.accountList[index]['name'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              trailing: Text(
                '₹${controller.accountList[index]["balance"]}.00',
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
