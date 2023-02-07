import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pony_logistics/src/features/core/models/dashboard/package_model.dart';
import 'package:pony_logistics/src/repository/package_repository/package_repository.dart';


class TextController extends GetxController {
  static TextController get instance => Get.find();

  final packageRepo = Get.put(PackageRepository());

  // TextField Controllers to get data from TextFields
  final partNumber = TextEditingController();
  final caseNumber = TextEditingController();
  final quantity = TextEditingController();
  final dateReceived = TextEditingController();
  // final dateDelivered = TextEditingController();

  // Get phoneNo from user and pass it to Auth Repository for Firebase Authentication
  Future<void> createPackage(PackageModel package) async {
    await packageRepo.createPackage(package);
  }
}
