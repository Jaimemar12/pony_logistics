import 'package:flutter/material.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/components/responsive.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/sizes.dart';

class Users extends StatelessWidget {
  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var textColor = !isDark ? tPrimaryColor : tAccentColor;

    return Container(
      height: Responsive.isDesktop(context) ? 420 : 405,
      width: double.infinity,
      padding: const EdgeInsets.all(appPadding),
      decoration: BoxDecoration(
        color: isDark ? tPrimaryColor : tAccentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateTime.now().year.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: textColor,
            ),
          ),
          // Expanded(
          //   // child: BarChartUsers(),
          // )
        ],
      ),
    );
  }
}
