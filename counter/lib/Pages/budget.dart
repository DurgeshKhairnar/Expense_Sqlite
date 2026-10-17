import 'package:counter/Widget/sectionHeders.dart';
import 'package:flutter/material.dart';

class BudgetPage extends StatefulWidget{
  const  BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPage();
}


class _BudgetPage extends State<BudgetPage>{

       @override
       Widget build(BuildContext conetxt){
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
                        'Budget',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                    const SizedBox(height: 10),
                    monthlyBudgetContainer(),
                    SectionHeader(
                      title: 'Categories',
                      onSeeAllPressed: () {
                        // Navigate to all accounts screen
                      },
                    ),
                    const SizedBox(height: 5),
                    
               ] 
             ) 
           ) 
         )
      );
    }

    Widget monthlyBudgetContainer(){
      return Container(
                        width:MediaQuery.of(context).size.width,
                        decoration:BoxDecoration(
                          borderRadius:BorderRadius.circular(5),
                          color:Colors.white,
                        ),
                        child:Padding(padding:EdgeInsets.symmetric(
                          vertical:10,
                          horizontal:20
                        ),
                        child:Column(children:[
                          Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Monthly Budget',style:TextStyle(
                                  color:Colors.grey[600],
                                  fontWeight:FontWeight.w500
                              )),
                               Text('Spent',style:TextStyle(
                                  color:Colors.grey[600],
                                  fontWeight:FontWeight.w500
                              ))
                          ],),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              Text('₹250.00',style:TextStyle(
                                  fontWeight:FontWeight.bold,
                                  fontSize:25
                              )),
                                Text('₹100.00',style:TextStyle(
                                  fontWeight:FontWeight.bold,
                                  fontSize:15
                              )),
                          ],),
                           const SizedBox(height: 10),
                           ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 10,
                              child: LinearProgressIndicator(
                                value: 0.65, // Value between 0.0 and 1.0
                                backgroundColor: Colors.grey[200],
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                              ),
                            ),
                          ),
                          const SizedBox(height:10),
                           const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '75% of budget used',
                              style: TextStyle(fontWeight: FontWeight.bold, color:Colors.grey),
                            ),
                          ),
                        ],
                       )
                      )
                  );
              
    }
}