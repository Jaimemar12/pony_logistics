import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pony_logistics/src/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/widgets/appbar.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/widgets/text_form_widget.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/widgets/today_packages.dart';
import 'package:pony_logistics/src/features/core/screens/packages/packages_screen.dart';

import '../../../../constants/colors.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Variables
    // final txtTheme = Theme.of(context).textTheme;
    final isDark = MediaQuery.of(context).platformBrightness ==
        Brightness.dark; //Dark mode
    var iconColor = isDark ? tPrimaryColor : tAccentColor;

    return SafeArea(
      child: Scaffold(
        appBar: DashboardAppBar(
          isDark: isDark,
        ),
        body: Container(
          padding: const EdgeInsets.all(tDashboardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Heading
              // Text(tDashboardTitle, style: txtTheme.bodyText2),
              // Text(tDashboardHeading, style: txtTheme.headline2),
              // const SizedBox(height: tDashboardPadding),

              //Search Box
              const TextFormWidget(),
              Row(
                children: [
                  Text("Today's Packages",
                      style: Theme.of(context).textTheme.headlineMedium),
                  const Spacer(),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: iconColor.withOpacity(0.1),
                    ),
                    child: IconButton(
                      onPressed: () => Get.to(() => const PackagesScreen()),
                      icon: const Icon(LineAwesomeIcons.search),
                      color: iconColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              const TodayPackages(),
              // DashboardSearchBox(txtTheme: txtTheme),
              // const SizedBox(height: tDashboardPadding),
              //
              // //Text Form Field
              // MyFormField(txtTheme: txtTheme),
              // const SizedBox(height: tDashboardPadding),
              //
              // //Categories
              // DashboardCategories(txtTheme: txtTheme),
              // const SizedBox(height: tDashboardPadding),
              //
              // //Banners
              // DashboardBanners(txtTheme: txtTheme, isDark: isDark),
              // const SizedBox(height: tDashboardPadding),
              //
              // //Top Course
              // Text(tDashboardTopCourses, style: txtTheme.headline4?.apply(fontSizeFactor: 1.2)),
              // DashboardTopCourses(txtTheme: txtTheme, isDark: isDark)
            ],
          ),
        ),
      ),
    );
  }
}
