import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pony_logistics/src/features/authentication/models/user_model.dart';
import 'package:pony_logistics/src/repository/user_repository/user_repository.dart';

import '../../../repository/authentication_repository/authentication_repository.dart';
import '../../../repository/google_sheets_repository/google_sheets_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final userRepo = Get.put(UserRepository());

  // TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  // Call these Functions from Design & they will do the backend
  Future<String?> registerUser(String email, String password) async {
    return await GoogleSheetsRepository.instance
        .createUserWithEmailAndPassword(email, password)
        .whenComplete(() {
      Get.snackbar("Success", "You account has been created.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
          duration: const Duration(seconds: 2));
    }).catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red,
          duration: const Duration(seconds: 2));
    });
    // As in the AuthenticationRepository we are calling setScreen Method
    // whenever there is change in the user state()
    // therefore when new user is authenticated. AuthenticationRepository detects
    // the change and call setScreen() to switch screens
  }

  // Get phoneNo from user and pass it to Auth Repository for Firebase Authentication
  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
    await registerUser(user.email, user.password);
  }

  void phoneAuthentication(String phoneNo) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
}
