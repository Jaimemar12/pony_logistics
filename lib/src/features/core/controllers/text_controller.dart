import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextController extends GetxController {
  static TextController get instance => Get.find();

  final partNumber = TextEditingController();
  final caseNumber = TextEditingController();
  final quantity = TextEditingController();
  final dateReceived = TextEditingController();
}
