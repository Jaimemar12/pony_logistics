import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pony_logistics/src/features/core/controllers/google_sheets_controller.dart';
import 'package:pony_logistics/src/features/core/controllers/profile_controller.dart';
import 'package:pony_logistics/src/features/core/controllers/text_controller.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/scan_picture_screen.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/submit_package_screen.dart';
import 'package:pony_logistics/src/features/core/screens/packages/update_package_screen.dart';
import 'package:pony_logistics/src/repository/user_repository/user_repository.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../models/dashboard/package_model.dart';
import '../dashboard/components/drawer_menu.dart';
import '../dashboard/components/responsive.dart';
import 'admin_dashboard.dart';

class ShipPackageScreen extends StatefulWidget {
  ShipPackageScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ShipPackageScreen();
  }
}

class _ShipPackageScreen extends State<ShipPackageScreen> {
  _ShipPackageScreen() : super();
  String caseNumber = '';
  String partNumber = '';
  bool rebuild = true;
  final packageController = GoogleSheetsController();
  final formKey = GlobalKey<FormState>();
  late Future<List<PackageModel>> packages;

  Future refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? tPrimaryColor : tAccentColor;
    var textColor = isDark ? tPrimaryColor : tAccentColor;

    getFuture() {
      if (rebuild) {
        setState(() {
          packages = packageController.getPackages(partNumber, caseNumber);
          rebuild = false;
        });
      }
      return packages;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            MediaQuery.of(context).platformBrightness != Brightness.dark
                ? tAccentColor
                : tPrimaryColor,
        onPressed: () {
          Get.to(() => ScanPictureScreen('ship'),
              transition: Transition.noTransition);
        },
        child: Icon(LineAwesomeIcons.camera),
      ),
      backgroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? tAccentColor
              : tPrimaryColor,
      drawer: const DrawerMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: DrawerMenu(),
              ),
            Expanded(
              flex: 5,
              child: FutureBuilder<List<PackageModel>>(
                future: getFuture(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List<PackageModel>? result = snapshot.data;

                      return SafeArea(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(appPadding),
                          child: Column(
                            children: [
                              Row(
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
                                  if (Responsive.isDesktop(context) ||
                                      Responsive.isTablet(context))
                                    Form(
                                        key: formKey,
                                        child: Flexible(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  controller: packageController
                                                      .partNumber,
                                                  keyboardType:
                                                      const TextInputType
                                                              .numberWithOptions(
                                                          decimal: false),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp('[0-9]')),
                                                  ],
                                                  decoration: InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                              height: 0),
                                                      label: const Text(
                                                        tPartNumber,
                                                        style: TextStyle(
                                                            fontSize: 11),
                                                      ),
                                                      prefixIcon: Icon(
                                                        LineAwesomeIcons
                                                            .slack_hashtag,
                                                        color: iconColor,
                                                      ),
                                                      border: const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0))),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          10.0)),
                                                          borderSide:
                                                              BorderSide(
                                                                  color:
                                                                      textColor,
                                                                  width: 1.0))),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                  textInputAction:
                                                      TextInputAction.go,
                                                  onFieldSubmitted: (value) {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      setState(() {
                                                        rebuild = true;
                                                        partNumber =
                                                            packageController
                                                                .partNumber
                                                                .value
                                                                .text;
                                                        caseNumber =
                                                            packageController
                                                                .caseNumber
                                                                .value
                                                                .text;
                                                      });
                                                      refresh();
                                                    }
                                                  },
                                                  controller: packageController
                                                      .caseNumber,
                                                  keyboardType:
                                                      const TextInputType
                                                              .numberWithOptions(
                                                          decimal: false),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp('[0-9]')),
                                                  ],
                                                  decoration: InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                              height: 0),
                                                      label: const Text(
                                                        tCaseNumber,
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                      ),
                                                      prefixIcon: Icon(
                                                        LineAwesomeIcons
                                                            .slack_hashtag,
                                                        color: iconColor,
                                                      ),
                                                      border: const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0))),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          10.0)),
                                                          borderSide:
                                                              BorderSide(
                                                                  color:
                                                                      textColor,
                                                                  width: 1.0))),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  if (Responsive.isMobile(context))
                                    Expanded(child: SizedBox()),
                                  IconButton(
                                      hoverColor: Colors.transparent,
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          setState(() {
                                            rebuild = true;
                                            partNumber = packageController
                                                .partNumber.value.text;
                                            caseNumber = packageController
                                                .caseNumber.value.text;
                                          });
                                          refresh();
                                        }
                                      },
                                      icon: Icon(
                                        LineAwesomeIcons.search,
                                        color: textColor,
                                      )),
                                  if (Responsive.isDesktop(context))
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: appPadding,
                                        vertical: appPadding / 2,
                                      ),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
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
                              if (Responsive.isMobile(context))
                                SizedBox(
                                  height: 10,
                                ),
                              if (Responsive.isMobile(context))
                              Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        textInputAction: TextInputAction.next,
                                        controller:
                                            packageController.partNumber,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: false),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "";
                                          } else {
                                            return null;
                                          }
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9]')),
                                        ],
                                        decoration: InputDecoration(
                                            errorStyle:
                                                const TextStyle(height: 0),
                                            label: const Text(
                                              tPartNumber,
                                              style: TextStyle(fontSize: 11),
                                            ),
                                            prefixIcon: Icon(
                                              LineAwesomeIcons.slack_hashtag,
                                              color: iconColor,
                                            ),
                                            border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color: textColor,
                                                    width: 1.0))),
                                      ),
                                      const SizedBox(height: tFormHeight - 20),
                                      TextFormField(
                                        textInputAction: TextInputAction.go,
                                        onFieldSubmitted: (value) {
                                          if (formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              rebuild = true;
                                              partNumber = packageController
                                                  .partNumber.value.text;
                                              caseNumber = packageController
                                                  .caseNumber.value.text;
                                            });
                                            refresh();
                                          }
                                        },
                                        controller:
                                            packageController.caseNumber,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: false),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "";
                                          } else {
                                            return null;
                                          }
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9]')),
                                        ],
                                        decoration: InputDecoration(
                                            errorStyle:
                                                const TextStyle(height: 0),
                                            label: const Text(
                                              tCaseNumber,
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            prefixIcon: Icon(
                                              LineAwesomeIcons.slack_hashtag,
                                              color: iconColor,
                                            ),
                                            border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10.0)),
                                                borderSide: BorderSide(
                                                    color: textColor,
                                                    width: 1.0))),
                                      ),
                                    ],
                                  )),
                              if (Responsive.isMobile(context))
                              const SizedBox(height: tFormHeight - 20),
                              ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  controller: scrollController,
                                  shrinkWrap: true,
                                  itemCount: result?.length,
                                  itemBuilder: (c, index) {
                                    return Column(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                color:
                                                    iconColor.withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                border: const Border(
                                                  bottom: BorderSide(),
                                                  top: BorderSide(),
                                                  left: BorderSide(),
                                                  right: BorderSide(),
                                                )),
                                            child: ListTile(
                                              leading: Container(
                                                  height: double.infinity,
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: isDark
                                                        ? tPrimaryColor
                                                        : tAccentColor,
                                                  ),
                                                  child: Icon(
                                                      LineAwesomeIcons.box,
                                                      color: result?[index]
                                                                  .status ==
                                                              'Available'
                                                          ? Colors.green
                                                          : Colors.red)),
                                              trailing: Container(
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: isDark
                                                        ? tPrimaryColor
                                                        : tAccentColor,
                                                  ),
                                                  child: IconButton(
                                                    onPressed: () => Get.to(
                                                      () => SubmitPackageScreen(
                                                          result?[index],
                                                          'ship'),
                                                      transition: Transition
                                                          .noTransition,
                                                    ),
                                                    icon: Icon(
                                                        LineAwesomeIcons.edit,
                                                        color: !isDark
                                                            ? tPrimaryColor
                                                            : tAccentColor),
                                                    color: isDark
                                                        ? tPrimaryColor
                                                        : tAccentColor,
                                                  ),
                                                ),
                                              ),
                                              title: AutoSizeText.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Container Name: ',
                                                      style: TextStyle(
                                                        color:
                                                            textColor, // set the color you want
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '${result?[index].containerName} ',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          decoration: TextDecoration
                                                              .underline // set the color you want
                                                          ),
                                                    ),
                                                    TextSpan(
                                                      text: 'Part Number: ',
                                                      style: TextStyle(
                                                        color:
                                                            textColor, // set the color you want
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '${result?[index].partNumber} ',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          decoration: TextDecoration
                                                              .underline // set the color you want
                                                          ),
                                                    ),
                                                    TextSpan(
                                                      text: 'Case Number: ',
                                                      style: TextStyle(
                                                        color:
                                                            textColor, // set the color you want
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '${result?[index].caseNumber}',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          decoration: TextDecoration
                                                              .underline // set the color you want
                                                          ),
                                                    ),
                                                    TextSpan(
                                                      text: '\tQuantity: ',
                                                      style: TextStyle(
                                                        color:
                                                            textColor, // set the color you want
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '${result?[index].quantity}',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          decoration: TextDecoration
                                                              .underline // set the color you want
                                                          ),
                                                    ),
                                                    TextSpan(
                                                      text: '\tDate Received: ',
                                                      style: TextStyle(
                                                        color:
                                                            textColor, // set the color you want
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '${result?[index].dateReceived}',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          decoration: TextDecoration
                                                              .underline // set the color you want
                                                          ),
                                                    ),
                                                    TextSpan(
                                                      text: '\tDate Shipped: ',
                                                      style: TextStyle(
                                                        color:
                                                            textColor, // set the color you want
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '${result?[index].dateShipped}',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          decoration: TextDecoration
                                                              .underline // set the color you want
                                                          ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '\tTrailer Number: ',
                                                      style: TextStyle(
                                                        color:
                                                            textColor, // set the color you want
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '${result?[index].trailerNumber}',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          decoration: TextDecoration
                                                              .underline // set the color you want
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                maxLines: 10,
                                                minFontSize: 17,
                                                maxFontSize:
                                                    20, // set the replacement text if overflowed
                                              ),
                                              minLeadingWidth: 0,
                                              // Text(
                                              //     "PN: ${todayPackages[index].partNumber} CNO: ${todayPackages[index].caseNumber} Q: ${todayPackages[index].quantity} DD: ${todayPackages[index].dateDelivered}"),
                                            )),
                                        const SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    );
                                  })
                            ],
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: appPadding, right: appPadding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Unable To Retrieve Data',
                                textAlign: TextAlign.center,
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(() => AdminDashboard(),
                                      transition: Transition.noTransition);
                                },
                                child: Text('Return home'),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: Text('Something went wrong'));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
