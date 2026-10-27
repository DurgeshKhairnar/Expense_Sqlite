import 'dart:developer';
import 'package:counter/Controllers/accountController.dart';
import 'package:counter/Controllers/authController.dart';
import 'package:counter/Controllers/categoryController.dart';
import 'package:counter/Controllers/transaction.dart';
import 'package:counter/Navigation/navigationBar.dart';
import 'package:counter/Widget/textFiledContainer.dart';
import 'package:counter/router/router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final TextEditingController _userNameController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final transactionController = Get.find<TransactionController>();
    final categoryController = Get.find<CategoryController>();
    final accountController = Get.find<AccountController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF7),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Wallet illustration
                      Center(
                        child: Container(
                          height: 125,
                          width: 125,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5F5E8),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Image.asset(
                            'assets/wallet.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      const SizedBox(height: 22),

                      // App title
                      Center(
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 29,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.8,
                            ),
                            children: [
                              TextSpan(
                                text: 'Expense ',
                                style: TextStyle(
                                  color: Color(0xFF202B23),
                                ),
                              ),
                              TextSpan(
                                text: 'Manager',
                                style: TextStyle(
                                  color: Color(0xFF269B50),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        'Track your expenses, build a better tomorrow.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF7B857D),
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Login card
                      Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: const Color(0xFFEAF0EA),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF24452D)
                                  .withValues(alpha: 0.06),
                              blurRadius: 25,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome Back!',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF202B23),
                              ),
                            ),

                            const SizedBox(height: 7),

                            const Text(
                              'Sign in to manage your money.',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF879087),
                              ),
                            ),

                            const SizedBox(height: 25),

                            const Text(
                              'Email or Phone Number',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Color(0xFF37443A),
                              ),
                            ),

                            const SizedBox(height: 9),

                            CustomTextFild(
                              controller: _userNameController,
                              hintText: 'Enter email or phone number',
                              prefixIcon: const Icon(
                                Icons.person_outline_rounded,
                                color: Color(0xFF8B968D),
                                size: 21,
                              ),
                              suffixIcon: null,
                            ),

                            const SizedBox(height: 20),

                            const Text(
                              'Password',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Color(0xFF37443A),
                              ),
                            ),

                            const SizedBox(height: 9),

                            Obx(
                              () => CustomTextFild(
                                controller: _passwordController,
                                hintText: 'Enter your password',
                                obscureText:
                                    authController.isHidden.value,
                                prefixIcon: const Icon(
                                  Icons.lock_outline_rounded,
                                  color: Color(0xFF8B968D),
                                  size: 21,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    authController
                                        .togglePasswordVisibility();
                                  },
                                  icon: Icon(
                                    authController.isHidden.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: const Color(0xFF8B968D),
                                    size: 21,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.forgetPasswordScreen);
                                  Get.snackbar(
                                    'Forgot Password',
                                    'Open your password recovery screen here.',
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 6,
                                  ),
                                  foregroundColor:
                                      const Color(0xFF269B50),
                                ),
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Login button
                            SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: ElevatedButton(
                                onPressed: () => _handleLogin(
                                  authController,
                                  transactionController,
                                  categoryController,
                                  accountController,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xFF269B50),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(15),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 9),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 26),

                      // Sign up navigation
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(fontSize: 14),
                            children: [
                              const TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(
                                  color: Color(0xFF7B857D),
                                ),
                              ),
                              TextSpan(
                                text: 'Sign Up',
                                style: const TextStyle(
                                  color: Color(0xFF269B50),
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(Routes.signupScreen);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      const Center(
                        child: Text(
                          'Your money. Your control.',
                          style: TextStyle(
                            color: Color(0xFFA1AAA2),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _handleLogin(
    AuthController authController,
    TransactionController transactionController,
    CategoryController categoryController,
    AccountController accountController,
  ) async {
    final box = GetStorage();

    final user = await authController.loginUser(
      userName: _userNameController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (user != null) {
      await box.write('isLogin', true);
      await box.write('userId', user['userId']);

      await Future.wait([
        transactionController.loadData(user['userId']),
        categoryController.loadData(user['userId']),
        accountController.loadData(user['userId']),
      ]);

      Get.snackbar(
        'Success',
        'Welcome back, ${user['userName']}!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.offAll(() => const MainScreen());
    } else {
      Get.snackbar(
        'Login Failed',
        'Invalid username or password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}