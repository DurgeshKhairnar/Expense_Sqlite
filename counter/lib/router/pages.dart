import 'package:counter/Navigation/navigationBar.dart';
import 'package:counter/Pages/addAccount.dart';
import 'package:counter/Pages/addCategories.dart';
import 'package:counter/Pages/calculator_screen.dart';
import 'package:counter/router/router.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static final router = [
      GetPage(
          name:Routes.navigation,
          page : () => const MainScreen(),
      ),
       GetPage(
          name:Routes.addAccount,
          page : () => const AccountPage(),
      ),
       GetPage(
          name:Routes.addCategories,
          page : () => const Categories(),
      ),
      GetPage(
          name:Routes.calculatorScreen,
          page : () => const Calculate(),
      )
  ];
}