import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pony_logistics/src/features/core/controllers/google_sheets_controller.dart';
import 'package:pony_logistics/src/features/core/controllers/package_controller.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';
import '../../../controllers/text_controller.dart';
import '../../../models/dashboard/package_model.dart';

class TextFormWidget extends StatefulWidget {
  const TextFormWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TextFormWidget();
  }
}

class _TextFormWidget extends State<TextFormWidget> {
  _TextFormWidget() : super();

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(PackageController());
    final controller = Get.put(GoogleSheetsController());
    final formKey = GlobalKey<FormState>();
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var textColor = isDark ? tPrimaryColor : tAccentColor;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.partNumber,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              decoration: InputDecoration(
                  label: const Text(tPartNumber),
                  prefixIcon: const Icon(LineAwesomeIcons.slack_hashtag),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: textColor, width: 1.0))),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: controller.caseNumber,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              decoration: InputDecoration(
                  label: const Text(tCaseNumber),
                  prefixIcon: const Icon(LineAwesomeIcons.slack_hashtag),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: textColor, width: 1.0))),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: controller.quantity,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              decoration: InputDecoration(
                  label: const Text(tQuantity),
                  prefixIcon: const Icon(LineAwesomeIcons.slack_hashtag),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: textColor, width: 1.0))),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: controller.dateReceived,
              readOnly: true,
              decoration: InputDecoration(
                  label: const Text(tDateDelivered),
                  prefixIcon: const Icon(Icons.calendar_today),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: textColor, width: 1.0))),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100));
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('MM-dd-yyyy').format(pickedDate);

                  setState(() {
                    controller.dateReceived.text =
                        formattedDate; //set output date to TextField value.
                  });
                }
              },
            ),
            const SizedBox(height: tFormHeight - 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    /// Email & Password Authentication
                    // SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());

                    /// For Phone Authentication
                    // SignUpController.instance.phoneAuthentication(controller.phoneNo.text.trim());

                    /*
                     =========
                     Todo:Step - 3 [Get User and Pass it to Controller]
                     =========
                    */

                    final package = PackageModel(
                        containerName: controller.containerName.text.trim(),
                        partNumber: controller.partNumber.text.trim(),
                        caseNumber: controller.caseNumber.text.trim(),
                        quantity: controller.quantity.text.trim(),
                        dateReceived: controller.dateReceived.text.trim());
                    await controller.createPackage(package);
                    // PackageController.instance.createPackage(package);
                    setState(() {
                      controller.containerName.text = "";
                      controller.partNumber.text = "";
                      controller.caseNumber.text = "";
                      controller.quantity.text = "";
                      controller.dateReceived.text = "";
                    });

                    // final user = UserModel(
                    //   email: controller.partNumber.text.trim(),
                    //   password: controller.caseNumber.text.trim(),
                    //   fullName: controller.quantity.text.trim(),
                    //   phoneNo: controller.dateReceived.text.trim(),
                    // );
                    // TextController.instance.createUser(user);
                  }
                },
                child: Text(tSubmit.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
