import 'package:flutter/material.dart';
import 'package:pony_logistics/src/features/core/screens/packages/search_package_content.dart';

import '../../../../constants/colors.dart';
import '../dashboard/components/drawer_menu.dart';
import '../dashboard/components/responsive.dart';

class SearchPackageScreen extends StatelessWidget {
  const SearchPackageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            const Expanded(
              flex: 5,
              child: SearchPackageContent(),
            )
          ],
        ),
      ),
    );
  }
}
