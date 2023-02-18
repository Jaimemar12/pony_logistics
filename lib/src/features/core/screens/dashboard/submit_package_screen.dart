import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import 'components/dashboard_content.dart';
import 'components/drawer_menu.dart';

import 'components/responsive.dart';
import 'submit_package_content.dart';

class SubmitPackageScreen extends StatelessWidget {
  SubmitPackageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.dark ? tAccentColor : tPrimaryColor,
      drawer: const DrawerMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context)) Expanded(child: DrawerMenu(),),
            Expanded(
              flex: 5,
              child: SubmitPackageContent(),
            )
          ],
        ),
      ),
    );
  }
}