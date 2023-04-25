import 'package:get/get.dart';
import 'package:pony_logistics/src/features/authentication/models/user_model.dart';
import 'package:pony_logistics/src/repository/authentication_repository/authentication_repository.dart';
import 'package:pony_logistics/src/repository/google_sheets_repository/google_sheets_repository.dart';
import 'package:pony_logistics/src/repository/user_repository/user_repository.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  /// Repositories
  final _authRepo = Get.put(GoogleSheetsRepository());
  final _userRepo = Get.put(UserRepository());

  /// Get User Email and pass to UserRepository to fetch user record.
  Future<UserModel?>? getUserData() {
    final currentUserEmail = _authRepo.getUserEmail;
    if (currentUserEmail != null) {
      return _userRepo.getUserDetails(currentUserEmail);
    } else {
      Get.snackbar("Error", "Login to continue",
          duration: const Duration(seconds: 2));
      return null;
    }
  }

  Future<String?> getUserName() async {
    final currentUserEmail = _authRepo.getUserEmail;
    if (currentUserEmail != null) {
      UserModel? currentUser = await _userRepo.getUserDetails(currentUserEmail);
      return currentUser?.fullName;
    } else {
      Get.snackbar("Error", "Login to continue",
          duration: const Duration(seconds: 2));
      return null;
    }
  }

  Future<void> createUser(UserModel user) async {
    final currentUserEmail = _authRepo.getUserEmail;
    if (currentUserEmail != null) {
      await _userRepo.createUser(user);
    } else {
      Get.snackbar("Error", "Login to continue",
          duration: const Duration(seconds: 2));
    }
  }

  /// Fetch List of user records.
  Future<List<UserModel>> getAllUsers() async => await _userRepo.getAllUsers();

  /// Update User Data
  updateRecord(UserModel user) async {
    await _userRepo.updateUserRecord(user);
    //Show some message or redirect to other screen here...
  }

  Future<void> deleteUser(UserModel user) async {
    final uID = _authRepo.getUserID;
    if (uID == null) {
      Get.snackbar("Error", "Package cannot be deleted.",
          duration: const Duration(seconds: 2));
    } else {
      bool success = await _userRepo.deleteUser(user.id.toString());
      if (success) {
        Get.snackbar("Success", "Package has been deleted.",
            duration: const Duration(seconds: 2));
      } else {
        Get.snackbar("Error", "Package could not be deleted.",
            duration: const Duration(seconds: 2));
      }
    }
  }
}
