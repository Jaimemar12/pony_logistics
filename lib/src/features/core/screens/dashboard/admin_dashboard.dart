import 'package:flutter/material.dart';
import 'package:pony_logistics/src/features/core/screens/packages/search_package_screen.dart';
import 'package:pony_logistics/src/repository/google_sheets_repository/google_sheets_repository.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../controllers/google_sheets_controller.dart';
import 'components/today_packages.dart';
import 'components/drawer_menu.dart';
import 'components/responsive.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pony_logistics/src/features/core/controllers/profile_controller.dart';
import 'package:pony_logistics/src/features/core/models/dashboard/package_model.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/components/users.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AdminDashboard();
  }
}

class _AdminDashboard extends State<AdminDashboard> {
  _AdminDashboard() : super();

  late Future<List<dynamic>> data;

  Future<List<dynamic>> getList() async {
    final userController = UserController();
    List<PackageModel> packages = await packageController.getAllPackages();
    String? userName = await userController.getUserName();
    var temp = [];
    temp.add(packages);
    temp.add(userName);
    return Future.value(temp);
  }

  @override
  void initState() {
    data = Future.value(getList());
    super.initState();
  }

  final packageController = GoogleSheetsController();

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var textColor = isDark ? tPrimaryColor : tAccentColor;
    Get.put(GoogleSheetsRepository());

    return Scaffold(
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
              child: FutureBuilder<List<dynamic>>(
                future: data,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List<PackageModel> packages = snapshot.data![0];
                      String userName = snapshot.data![1];

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
                                  Expanded(
                                    child: TextFormField(
                                      controller: packageController.partNumber,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      textInputAction: TextInputAction.go,
                                      onFieldSubmitted: (value) {
                                        Get.to(
                                            () => SearchPackageScreen(
                                                value, "", ""),
                                            transition:
                                                Transition.noTransition);
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]')),
                                      ],
                                      decoration: InputDecoration(
                                          label: Text(tPartNumber),
                                          prefixIcon: Icon(
                                            LineAwesomeIcons.slack_hashtag,
                                            color: textColor,
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
                                  ),
                                  IconButton(
                                      hoverColor: Colors.transparent,
                                      onPressed: () {
                                        setState(() {
                                          data = Future.value(getList());
                                        });
                                      },
                                      icon: Icon(
                                        LineAwesomeIcons.alternate_redo,
                                        color: textColor,
                                      )),
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
                                        if (!Responsive.isMobile(context))
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: appPadding / 2),
                                            child: Text(
                                              'Hi, ${userName}',
                                              style: TextStyle(
                                                color: textColor,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: appPadding,
                              ),
                              Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Column(
                                          children: [
                                            const Users(0.0),
                                            if (Responsive.isMobile(context))
                                              const SizedBox(
                                                height: appPadding,
                                              ),
                                            if (Responsive.isMobile(context))
                                              TodayPackages(packages),
                                          ],
                                        ),
                                      ),
                                      if (!Responsive.isMobile(context))
                                        const SizedBox(
                                          width: appPadding,
                                        ),
                                      if (!Responsive.isMobile(context))
                                        Expanded(
                                          flex: 2,
                                          child: TodayPackages(packages),
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: appPadding,
                                  ),
                                  const Users(0.0),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
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
