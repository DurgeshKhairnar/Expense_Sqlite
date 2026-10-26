import 'dart:developer';

import 'package:counter/Controllers/accountController.dart';
import 'package:counter/Controllers/authController.dart';
import 'package:counter/Controllers/categoryController.dart';
import 'package:counter/Navigation/navigationBar.dart';
import 'package:counter/Widget/textFiledContainer.dart';
import 'package:counter/dataBaseHelper.dart';
import 'package:counter/router/router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreen();
}

class _SignScreen extends State<SignScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthController _authController = Get.find<AuthController>();
      final AccountController accountController = Get.find<AccountController>();
    final CategoryController categoryController =
        Get.find<CategoryController>();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 249),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(width: 100, height: 100, 'assets/wallet.png'),
                const SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: 'Expense ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Manager ',
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Track Your Expenses, Build a Better Tomorrow',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextFild(
                  controller: _userNameController,
                  hintText: 'Email or Phone Number',
                  suffixIcon: null,
                  prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                ),
                const SizedBox(height: 5),
                CustomTextFild(
                  prefixIcon: Icon(Icons.lock_outlined, color: Colors.grey),
                  controller: _passwordController,
                  hintText: 'Password',
                  suffixIcon: Icon(
                    Icons.visibility_outlined,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed:() =>  _handleLogin(_authController,accountController,categoryController),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Signup',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 15),
                    children: [
                      const TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(Routes.loginScreen);
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin(AuthController authController,AccountController accountController,CategoryController categoryController) async {
   try{
       final id = await authController.signupUser(
     userName: _userNameController.text.trim(), password: _passwordController.text.trim(),
    );
      if(id > 0){
        await accountController.insertDbAccount(id);
         await categoryController.insertCategories(id);
           Get.snackbar(
            'Successfully',
            'Signup',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
      } 
   }catch (e){
      Get.snackbar(
      'Registration Failed', 
      'Username "${_userNameController.text}" is already taken. Please choose another one.', 
      backgroundColor: Colors.red, 
      colorText: Colors.white,
    );
   }
}}
