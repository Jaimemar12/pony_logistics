import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pony_logistics/src/features/core/models/dashboard/package_model.dart';
import 'package:pony_logistics/src/repository/package_repository/package_repository.dart';

class TextController extends GetxController {
  static TextController get instance => Get.find();

  final partNumber = TextEditingController();
  final caseNumber = TextEditingController();
  final quantity = TextEditingController();
  final dateReceived = TextEditingController();
}
