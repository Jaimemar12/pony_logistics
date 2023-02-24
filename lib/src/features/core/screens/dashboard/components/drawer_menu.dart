import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/admin_dashboard.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/submit_package_screen.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/sizes.dart';
import '../../packages/search_package_screen.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var textColor = !isDark ? tPrimaryColor : tAccentColor;

    return Drawer(
      child: Container(
        color: isDark ? tPrimaryColor : tAccentColor,
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(appPadding),
              child: Image.asset(
                "assets/images/image.png",
                height: 100,
                width: 200,
              ),
            ),
            ListTile(
              hoverColor: Colors.black,
              textColor: textColor,
              minLeadingWidth: 0,
              title: const Text('Home'),
              leading: Icon(
                LineAwesomeIcons.home,
                color: textColor,
              ),
              onTap: () {
                Get.to(() => AdminDashboard(),
                    transition: Transition.noTransition);
              },
            ),
            ListTile(
              hoverColor: Colors.black,
              textColor: textColor,
              minLeadingWidth: 0,
              title: const Text('Submit Package'),
              leading: Icon(
                LineAwesomeIcons.boxes,
                color: textColor,
              ),
              onTap: () {
                Get.to(() => SubmitPackageScreen(),
                    transition: Transition.noTransition);
              },
            ),
            ListTile(
              hoverColor: Colors.black,
              textColor: textColor,
              minLeadingWidth: 0,
              title: const Text('Search Package'),
              leading: Icon(
                LineAwesomeIcons.boxes,
                color: textColor,
              ),
              onTap: () {
                Get.to(() => SearchPackageScreen(),
                    transition: Transition.noTransition);
              },
            ),
            ListTile(
              hoverColor: Colors.black,
              textColor: textColor,
              minLeadingWidth: 0,
              title: const Text('Statistics'),
              leading: Icon(
                LineAwesomeIcons.bar_chart,
                color: textColor,
              ),
              onTap: () {},
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: appPadding * 2),
              child: Divider(
                color: grey,
                thickness: 0.2,
              ),
            ),
            ListTile(
              hoverColor: Colors.black,
              textColor: textColor,
              minLeadingWidth: 0,
              title: const Text('Settings'),
              leading: Icon(
                LineAwesomeIcons.tools,
                color: textColor,
              ),
              onTap: () {},
            ),
            ListTile(
              hoverColor: Colors.black,
              textColor: textColor,
              minLeadingWidth: 0,
              title: const Text('Logout'),
              leading: Icon(
                LineAwesomeIcons.door_open,
                color: textColor,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
