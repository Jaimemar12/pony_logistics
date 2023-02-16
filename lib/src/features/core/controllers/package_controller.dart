// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:pony_logistics/src/features/core/models/dashboard/package_model.dart';
// import 'package:pony_logistics/src/repository/authentication_repository/authentication_repository.dart';
// import 'package:pony_logistics/src/repository/package_repository/package_repository.dart';
//
// class PackageController extends GetxController {
//   static PackageController get instance => Get.find();
//
//   /// Repositories
//   final _authRepo = Get.put(AuthenticationRepository());
//   final _packageRepo = Get.put(PackageRepository());
//
//   final partNumber = TextEditingController();
//   final caseNumber = TextEditingController();
//   final quantity = TextEditingController();
//   final dateReceived = TextEditingController();
//   // final dateDelivered = TextEditingController();
//
//   /// Get User Email and pass to UserRepository to fetch user record.
//   // getPackageData(String partNumber) {
//   //   final currentUserEmail = _authRepo.getUserEmail;
//   //   if (currentUserEmail != null) {
//   //     return _packageRepo.getPackageDetails(partNumber);
//   //   } else {
//   //     Get.snackbar("Error", "Login to continue",
//   //         duration: const Duration(seconds: 2));
//   //   }
//   // }
//
//   // /// Fetch List of package records.
//   // Future<List<PackageModel>> getAllPackages() async =>
//   //     await _packageRepo.allPackages();
//
//   // Future<List<PackageModel>> getTodayPackages() async =>
//   //     await _packageRepo.todayPackages();
//
//   // Future<List<PackageModel>> getPackagesBetween(
//   //         String startDate, String endDate) async =>
//   //     await _packageRepo.getPackagesBetween(startDate, endDate);
//
//   // Future<List<PackageModel>> getPackages(String partNumber) async =>
//   //     await _packageRepo.getPackages(partNumber);
//
//   // Future<void> createPackage(PackageModel package) async {
//   //   await _packageRepo.createPackage(package);
//   // }
//
//   // /// Update Package Data
//   // updateRecord(PackageModel package) async {
//   //   await _packageRepo.updatePackageRecord(package);
//   //   //Show some message or redirect to other screen here...
//   // }
//
//   // Future<void> deletePackage(PackageModel package) async {
//   //   final uID = _authRepo.getUserID;
//   //   if (uID == null) {
//   //     Get.snackbar("Error", "Package cannot be deleted.",
//   //         duration: const Duration(seconds: 2));
//   //   } else {
//   //     await _packageRepo.deletePackage(package.id.toString());
//   //     Get.snackbar("Success", "Package has been deleted.",
//   //         duration: const Duration(seconds: 2));
//   //   }
//   // }
// }
