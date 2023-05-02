import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/scan_picture_screen.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../controllers/google_sheets_controller.dart';
import '../../models/dashboard/package_model.dart';
import 'components/drawer_menu.dart';

import 'components/responsive.dart';

class SubmitPackageScreen extends StatefulWidget {
  SubmitPackageScreen(this.updatePackage, this.action, {Key? key})
      : super(key: key);
  PackageModel? updatePackage;
  String? action;

  @override
  State<StatefulWidget> createState() {
    return _SubmitPackageScreen(updatePackage, action);
  }
}

class _SubmitPackageScreen extends State<SubmitPackageScreen> {
  _SubmitPackageScreen([this.updatePackage, this.action]) : super();

  final packageController = GoogleSheetsController();
  final formKey = GlobalKey<FormState>();
  PackageModel? updatePackage;
  String? action;

  @override
  void initState() {
    // TODO: implement initState
    if (updatePackage != null) {
      packageController.partNumber.text = updatePackage!.partNumber;
      packageController.containerName.text = updatePackage!.containerName;
      packageController.caseNumber.text = updatePackage!.caseNumber;
      packageController.quantity.text = updatePackage!.quantity;
      packageController.dateReceived.text = updatePackage!.dateReceived;
      packageController.dateShipped.text = updatePackage!.dateShipped!;
      packageController.trailerNumber.text = updatePackage!.trailerNumber!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? tPrimaryColor : tAccentColor;
    var textColor = isDark ? tPrimaryColor : tAccentColor;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: action == 'submit'
          ? FloatingActionButton(
              backgroundColor:
                  MediaQuery.of(context).platformBrightness != Brightness.dark
                      ? tAccentColor
                      : tPrimaryColor,
              onPressed: () {
                Get.to(() => ScanPictureScreen('submit'),
                    transition: Transition.noTransition);
              },
              child: const Icon(LineAwesomeIcons.camera),
            )
          : SizedBox(width: 2),
      backgroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? tAccentColor
              : tPrimaryColor,
      drawer: const DrawerMenu(),
      body: Builder(
        builder: (context) => SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Responsive.isDesktop(context))
                const Expanded(
                  child: DrawerMenu(),
                ),
              Expanded(
                flex: 5,
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(appPadding),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: Responsive.isDesktop(context)
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.spaceBetween,
                          children: [
                            if (!Responsive.isDesktop(context))
                              IconButton(
                                onPressed: () =>
                                    Scaffold.of(context).openDrawer(),
                                icon: Icon(
                                  Icons.menu,
                                  color: textColor,
                                ),
                              ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: appPadding,
                                vertical: appPadding / 2,
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset(
                                      'assets/images/photo3.jpg',
                                      height: 38,
                                      width: 38,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "";
                                  } else {
                                    return null;
                                  }
                                },
                                textInputAction: TextInputAction.next,
                                controller: packageController.containerName,
                                decoration: InputDecoration(
                                    errorStyle: const TextStyle(height: 0),
                                    label: const Text('Container Name'),
                                    prefixIcon: Icon(
                                      LineAwesomeIcons.slack_hashtag,
                                      color: iconColor,
                                    ),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: textColor, width: 1.0))),
                              ),
                              const SizedBox(height: tFormHeight - 20),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "";
                                  } else {
                                    return null;
                                  }
                                },
                                textInputAction: TextInputAction.next,
                                controller: packageController.partNumber,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]')),
                                ],
                                decoration: InputDecoration(
                                    errorStyle: const TextStyle(height: 0),
                                    label: const Text(tPartNumber),
                                    prefixIcon: Icon(
                                      LineAwesomeIcons.slack_hashtag,
                                      color: iconColor,
                                    ),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: textColor, width: 1.0))),
                              ),
                              const SizedBox(height: tFormHeight - 20),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "";
                                  } else {
                                    return null;
                                  }
                                },
                                textInputAction: TextInputAction.next,
                                controller: packageController.caseNumber,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]')),
                                ],
                                decoration: InputDecoration(
                                    errorStyle: const TextStyle(height: 0),
                                    label: const Text(tCaseNumber),
                                    prefixIcon: Icon(
                                      LineAwesomeIcons.slack_hashtag,
                                      color: iconColor,
                                    ),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: textColor, width: 1.0))),
                              ),
                              const SizedBox(height: tFormHeight - 20),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "";
                                  } else {
                                    return null;
                                  }
                                },
                                textInputAction: TextInputAction.next,
                                controller: packageController.quantity,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]')),
                                ],
                                decoration: InputDecoration(
                                    errorStyle: const TextStyle(height: 0),
                                    label: const Text(tQuantity),
                                    prefixIcon: Icon(
                                      LineAwesomeIcons.slack_hashtag,
                                      color: iconColor,
                                    ),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: textColor, width: 1.0))),
                              ),
                              const SizedBox(height: tFormHeight - 20),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: packageController.dateReceived,
                                readOnly: true,
                                decoration: InputDecoration(
                                    errorStyle: const TextStyle(height: 0),
                                    label: const Text(tDateReceived),
                                    prefixIcon: Icon(
                                      Icons.calendar_today,
                                      color: iconColor,
                                    ),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: textColor, width: 1.0))),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100));
                                  if (pickedDate != null) {
                                    String formattedDate =
                                        DateFormat('MM/dd/yyyy')
                                            .format(pickedDate);
                                    setState(() {
                                      packageController.dateReceived.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  }
                                },
                              ),
                              if (action != 'submit')
                                const SizedBox(height: tFormHeight - 20),
                              if (action != 'submit')
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty && action != 'edit') {
                                      return "";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: packageController.dateShipped,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                      errorStyle: const TextStyle(height: 0),
                                      label: const Text(tDateShipped),
                                      prefixIcon: Icon(
                                        Icons.calendar_today,
                                        color: iconColor,
                                      ),
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: textColor, width: 1.0))),
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100));
                                    if (pickedDate != null) {
                                      String formattedDate =
                                          DateFormat('MM/dd/yyyy')
                                              .format(pickedDate);
                                      setState(() {
                                        packageController.dateShipped.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    }
                                  },
                                ),
                              if (action != 'submit')
                                const SizedBox(height: tFormHeight - 20),
                              if (action != 'submit')
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty && action != 'edit') {
                                      return "";
                                    } else {
                                      return null;
                                    }
                                  },
                                  textInputAction: TextInputAction.go,
                                  onFieldSubmitted: (value) {},
                                  controller: packageController.trailerNumber,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                      errorStyle: const TextStyle(height: 0),
                                      label: const Text(tTrailerNumber),
                                      prefixIcon: Icon(
                                        LineAwesomeIcons.slack_hashtag,
                                        color: iconColor,
                                      ),
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: textColor, width: 1.0))),
                                ),
                              const SizedBox(height: tFormHeight - 10),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      // await googleSheetsController.createPackage(package);
                                      if (action == 'submit') {
                                        final package = PackageModel(
                                            containerName: packageController
                                                .containerName.text
                                                .trim(),
                                            partNumber: packageController
                                                .partNumber.text
                                                .trim(),
                                            caseNumber: packageController
                                                .caseNumber.text
                                                .trim(),
                                            quantity: packageController
                                                .quantity.text
                                                .trim(),
                                            dateReceived: packageController
                                                .dateReceived.text
                                                .trim(),
                                            dateShipped: 'null',
                                            trailerNumber: 'null',
                                            status: 'Available');
                                        await packageController
                                            .createPackage(package);
                                      } else {
                                        if(packageController.dateShipped.text.isEmpty){
                                          print('Empty');
                                        }

                                        await packageController.updateRecord(
                                            updatePackage!,
                                            packageController
                                                .containerName.text,
                                            packageController.partNumber.text,
                                            packageController.caseNumber.text,
                                            packageController.quantity.text,
                                            packageController.dateReceived.text,
                                            packageController.dateShipped.text,
                                            packageController
                                                .trailerNumber.text,
                                            action == 'ship'
                                                ? 'Unavailable'
                                                : updatePackage?.status);
                                      }
                                      setState(() {
                                        packageController.containerName.text =
                                            action != 'submit'
                                                ? ""
                                                : packageController
                                                    .containerName.text;
                                        packageController.partNumber.text = "";
                                        packageController.caseNumber.text = "";
                                        packageController.quantity.text = "";
                                        packageController.dateReceived.text =
                                            "";
                                        packageController.dateShipped.text = "";
                                        packageController.trailerNumber.text =
                                            "";
                                      });
                                    }
                                  },
                                  child: Text(tSubmit.toUpperCase()),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
