import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pony_logistics/src/features/core/screens/profile/update_profile_screen.dart';
import 'package:pony_logistics/src/repository/authentication_repository/authentication_repository.dart';
import '../../../../../constants/colors.dart';
import '../../../../../constants/image_strings.dart';
import '../../../../../constants/text_strings.dart';
import '../../profile/profile_screen.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leading: IconButton(
          onPressed: () => Get.to(() => const ProfileScreen()),
          icon: const Icon(Icons.menu),
          color: isDark ? tWhiteColor : tDarkColor),
      title: Text(tAppName, style: Theme.of(context).textTheme.headline4),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55);
}
