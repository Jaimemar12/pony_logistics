import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pony_logistics/src/features/core/controllers/google_sheets_controller.dart';
import 'package:pony_logistics/src/repository/google_sheets_repository/google_sheets_repository.dart';

import '../../../repository/authentication_repository/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();

  //Call this Function from Design & it will do the rest
  Future<void> loginUser(String email, String password) async {
    String? error = await AuthenticationRepository.instance
        .loginWithEmailAndPassword(email, password);
    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  Future<void> loginUserMac(String email, String password) async {
    String? error = await GoogleSheetsRepository.loginWithEmailAndPasswordWindows(email, password);
    print(error);
    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  void clear(){
    email.clear();
    password.clear();
  }
}
