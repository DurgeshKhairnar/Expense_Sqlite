import 'package:counter/Controllers/transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// ignore: camel_case_types
class Monthly_budget extends StatefulWidget {
  const Monthly_budget({super.key});
  @override
  State<Monthly_budget> createState() => _Monthly_budget();
}

// ignore: camel_case_types
class _Monthly_budget extends State<Monthly_budget> {

  final _budgetController = TextEditingController();

  final box = GetStorage();

  final transactionController = Get.find<TransactionController>();

  
  @override
  void initState(){
      super.initState();
      budgetCalculation();
  }

  double budgetCalculation(){
    double monthlyBudget = double.tryParse(box.read('budget')) ?? 00;
    double expenses = transactionController.totalMonthExpense;
       if(monthlyBudget <= 0) return 0;
    return (expenses / monthlyBudget).clamp(0.0, 1.0);
  }

  double spentPercentage() {
  double budget =
      double.tryParse(box.read('budget')?.toString() ?? '') ?? 0;

  double spent =
      transactionController.totalMonthExpense.toDouble();

  if (budget <= 0) return 0;

  return (spent / budget) * 100;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 249),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children:[
              const SizedBox(height:10),
                monthlyBudgetContainer(transactionController),
            ]
           ),
        ),
      ),
    );
  }

  

void budgetPop() {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text("Add Monthly Budget"),
        content: TextField(
          controller: _budgetController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Enter Budget Amount',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async{
                if(_budgetController.text.isNotEmpty){
                    await box.write('budget', _budgetController.text);
                }
              Navigator.pop(dialogContext);
              _budgetController.clear();
              setState((){});
            },
            child: const Text("Add"),
          ),
        ],
      );
    },
  );
}


    Widget monthlyBudgetContainer(TransactionController transactionController) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Monthly Budget',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Spent',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹ ${box.read('budget') ?? 00}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                IconButton(icon: Icon(Icons.add_circle_outline),onPressed:budgetPop),
                Text(
                  '₹ ${transactionController.totalMonthExpense.toString()}0',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 10,
                child: LinearProgressIndicator(
                  value: budgetCalculation(), 
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Colors.deepPurple,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${spentPercentage().toStringAsFixed(1)}% of budget used',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
