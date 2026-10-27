import 'package:counter/Controllers/accountController.dart';
import 'package:counter/Controllers/authController.dart';
import 'package:counter/Controllers/categoryController.dart';
import 'package:counter/Widget/textFiledContainer.dart';
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
    final accountController = Get.find<AccountController>();
    final categoryController = Get.find<CategoryController>();

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
                          height: 120,
                          width: 120,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5F5E8),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Image.asset(
                            'assets/wallet.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // App title
                      Center(
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 28,
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

                      const SizedBox(height: 8),

                      const Text(
                        'Track your expenses, build a better tomorrow.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF7B857D),
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Signup card
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
                              'Create Account',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF202B23),
                              ),
                            ),

                            const SizedBox(height: 7),

                            const Text(
                              'Start managing your money smarter.',
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
                                hintText: 'Create a strong password',
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

                            const SizedBox(height: 26),

                            // Signup button
                            SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: ElevatedButton(
                                onPressed: () => _handleLogin(
                                  authController,
                                  accountController,
                                  categoryController,
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
                                      'Create Account',
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

                      const SizedBox(height: 25),

                      // Login navigation
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(fontSize: 14),
                            children: [
                              const TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(
                                  color: Color(0xFF7B857D),
                                ),
                              ),
                              TextSpan(
                                text: 'Login',
                                style: const TextStyle(
                                  color: Color(0xFF269B50),
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
    AccountController accountController,
    CategoryController categoryController,
  ) async {
    try {
      final id = await authController.signupUser(
        userName: _userNameController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (id > 0) {
        await accountController.insertDbAccount(id);
        await categoryController.insertCategories(id);

        Get.snackbar(
          'Success',
          'Account created successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offNamed(Routes.loginScreen);
      }
    } catch (e) {
      Get.snackbar(
        'Registration Failed',
        'Username "${_userNameController.text}" is already taken. Please choose another one.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}