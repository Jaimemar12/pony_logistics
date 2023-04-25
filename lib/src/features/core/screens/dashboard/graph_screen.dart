import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pony_logistics/src/features/core/screens/packages/search_package_screen.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../controllers/google_sheets_controller.dart';
import 'components/analytic_cards.dart';
import 'components/today_packages.dart';
import 'components/drawer_menu.dart';
import 'components/responsive.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pony_logistics/src/features/authentication/models/user_model.dart';
import 'package:pony_logistics/src/features/core/controllers/profile_controller.dart';
import 'package:pony_logistics/src/features/core/models/dashboard/package_model.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/components/top_referrals.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/components/users.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/components/users_by_device.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/components/viewers.dart';
import 'package:pony_logistics/src/features/core/screens/menu/menu_screen.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GraphScreen();
  }
}

class _GraphScreen extends State<GraphScreen> {
  _GraphScreen() : super();

  late Future<List<dynamic>> data;

  Future<List<dynamic>> getList() async {
    final userController = UserController();
    List<PackageModel> packages = await packageController.getAllPackages();
    UserModel? user = await userController.getUserData();
    var temp = [];
    temp.add(packages);
    temp.add(user);
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
                      UserModel user = snapshot.data![1];

                      return SafeArea(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(appPadding),
                          child: Users(775),
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
