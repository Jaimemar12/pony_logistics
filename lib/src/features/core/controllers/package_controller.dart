import 'package:get/get.dart';
import 'package:pony_logistics/src/features/core/models/dashboard/package_model.dart';
import 'package:pony_logistics/src/repository/authentication_repository/authentication_repository.dart';
import 'package:pony_logistics/src/repository/package_repository/package_repository.dart';

class PackageController extends GetxController {
  static PackageController get instance => Get.find();

  /// Repositories
  final _authRepo = Get.put(AuthenticationRepository());
  final _packageRepo = Get.put(PackageRepository());

  /// Get User Email and pass to UserRepository to fetch user record.
  getPackageData() {
    final currentUserEmail = _authRepo.getUserEmail;
    if (currentUserEmail != null) {
      return _packageRepo.getPackageDetails(currentUserEmail);
    } else {
      Get.snackbar("Error", "Login to continue",
          duration: const Duration(seconds: 2));
    }
  }

  /// Fetch List of package records.
  Future<List<PackageModel>> getAllPackages() async =>
      await _packageRepo.allPackages();

  Future<List<PackageModel>> getTodayPackages() async =>
      await _packageRepo.todayPackages();

  /// Update Package Data
  updateRecord(PackageModel package) async {
    await _packageRepo.updatePackageRecord(package);
    //Show some message or redirect to other screen here...
  }

  Future<void> deletePackage() async {
    final uID = _authRepo.getUserID;
    if (uID == null) {
      Get.snackbar("Error", "Package cannot be deleted.",
          duration: const Duration(seconds: 2));
    } else {
      await _packageRepo.deletePackage(uID);
      Get.snackbar("Success", "Package has been deleted.",
          duration: const Duration(seconds: 2));
      // You can call your redirection to other screen here...
      // OR call the LOGOUT() function.
    }
  }
}
