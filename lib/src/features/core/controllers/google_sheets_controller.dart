import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pony_logistics/src/features/core/models/dashboard/package_model.dart';
import 'package:pony_logistics/src/repository/authentication_repository/authentication_repository.dart';
import 'package:pony_logistics/src/repository/google_sheets_repository/google_sheets_repository.dart';

class GoogleSheetsController extends GetxController {
  static GoogleSheetsController get instance => Get.find();

  /// Repositories
  final _packageRepo = Get.put(GoogleSheetsRepository());
  final containerName = TextEditingController();
  final partNumber = TextEditingController();
  final caseNumber = TextEditingController();
  final quantity = TextEditingController();
  final dateReceived = TextEditingController();
  final dateShipped = TextEditingController();
  final trailerNumber = TextEditingController();

  Future<List<PackageModel>> getAllPackages() async =>
      await _packageRepo.getAllPackages();

  Future<List<PackageModel>> getPackages(String partNumber,
      [String? caseNumber]) async {
    return await _packageRepo.getPackages(partNumber, caseNumber);
  }

  Future<List<PackageModel>> getAvailablePackages(String partNumber) async {
    return await _packageRepo.getAvailablePackages(partNumber);
  }

  Future<List<PackageModel>> getPackagesBetween(
          String startDate, String endDate) async =>
      await _packageRepo.getPackagesBetween(startDate, endDate);

  Future<List<PackageModel>> getAvailablePackagesBetween(String startDate, String endDate) async =>
      await _packageRepo.getAvailablePackagesBetween(startDate, endDate);

  Future<void> createPackage(PackageModel package) async {
    await _packageRepo.createPackage(package);
  }

  // /// Update Package Data
  Future<void> updateRecord(
      PackageModel package,
      String containerName,
      String partNumber,
      String caseNumber,
      String quantity,
      String dateReceived,
      [String? dateShipped,
      String? trailerNumber,
      String? status]) async {
    await _packageRepo.updatePackageRecord(
        package, containerName, partNumber, caseNumber, quantity, dateReceived, dateShipped, trailerNumber, status);
  }

  Future<List<PackageModel>> getTodayPackages() async =>
      await _packageRepo.getTodayPackages();

  //
  Future<void> deletePackage(PackageModel package) async {
    final uID = _packageRepo.getUserID;
    if (uID == null) {
      Get.snackbar("Error", "Package cannot be deleted.",
          duration: const Duration(seconds: 2));
    } else {
      bool success = await _packageRepo.deletePackage(package.id.toString());
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
