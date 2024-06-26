import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pony_logistics/src/features/core/models/dashboard/package_model.dart';

class PackageRepository extends GetxController {
  static PackageRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Store package data
  Future<void> createPackage(PackageModel package) async {
    await _db.collection("Packages").add(package.toJson()).whenComplete(() {
      Get.snackbar("Success", "Package has been created.",
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
  }

  /// Fetch Package Specific details
  Future<PackageModel> getPackageDetails(String partNumber) async {
    final snapshot = await _db
        .collection("Packages")
        .where("PartNumber", isEqualTo: partNumber)
        .get();
    final packageData =
        snapshot.docs.map((e) => PackageModel.fromSnapshot(e)).single;
    return packageData;
  }

  /// Fetch All Packages
  Future<List<PackageModel>> allPackages() async {
    final snapshot = await _db
        .collection("Packages")
        .orderBy('DateDelivered', descending: true)
        .get();
    final packageData =
        snapshot.docs.map((e) => PackageModel.fromSnapshot(e)).toList();
    return packageData;
  }

  Future<List<PackageModel>> todayPackages() async {
    final DateTime dateTime = DateTime.now();
    final snapshot = await _db
        .collection("Packages")
        .where('DateDelivered',
            isEqualTo: DateFormat('MM-dd-yyyy').format(dateTime))
        .get();
    final packageData =
        snapshot.docs.map((e) => PackageModel.fromSnapshot(e)).toList();
    return packageData;
  }

  Future<List<PackageModel>> getPackages(String partNumber) async {
    final snapshot = await _db
        .collection("Packages")
        .where('PartNumber', isEqualTo: partNumber)
        .get();
    final packageData =
        snapshot.docs.map((e) => PackageModel.fromSnapshot(e)).toList();
    return packageData;
  }

  Future<List<PackageModel>> packagesBetween(
      String startDate, String endDate) async {
    final snapshot = await _db
        .collection("Packages")
        .where('DateDelivered',
            isGreaterThanOrEqualTo: startDate, isLessThanOrEqualTo: endDate)
        .get();
    final packageData =
        snapshot.docs.map((e) => PackageModel.fromSnapshot(e)).toList();
    return packageData;
  }

  /// Update Package details
  Future<void> updatePackageRecord(PackageModel package) async {
    await _db.collection("Packages").doc(package.id).update(package.toJson());
  }

  /// Delete Package Data
  Future<void> deletePackage(String id) async {
    await _db.collection("Packages").doc(id).delete();
  }
}
