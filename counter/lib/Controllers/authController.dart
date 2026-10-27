import 'package:counter/dataBaseHelper.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AuthController extends GetxController {

  RxInt userId = 0.obs;

  var isHidden = true.obs;


  void togglePasswordVisibility() {
    isHidden.value = !isHidden.value;
  }
  
  Future<int> signupUser({
    required String userName,
    required String password,
  }) async {
    final id = await DatabaseHelper.instance.insertUser(userName, password);
    return id;
  }

  Future<Map<String, dynamic>?> loginUser({
    required String userName,
    required String password,
  }) async {
    final user = await DatabaseHelper.instance.checkLogin(userName, password);
    return user;
  }

  Future<int> updatePassword({
  required String userName,
  required String newPassword,
})async{
    final id = await DatabaseHelper.instance.updateUserPassword(userName: userName, newPassword: newPassword);
    return id;
  }
}
