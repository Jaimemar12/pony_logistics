// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../constants/colors.dart';
// import '../../../../../constants/text_strings.dart';
// import '../../menu/menu_screen.dart';
//
// class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const DashboardAppBar({
//     Key? key,
//     required this.isDark,
//   }) : super(key: key);
//
//   final bool isDark;
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       elevation: 0,
//       centerTitle: true,
//       backgroundColor: Colors.transparent,
//       leading: IconButton(
//           onPressed: () => Get.to(
//                 () => const MenuScreen(),
//                 transition: Transition.noTransition,
//               ),
//           icon: const Icon(Icons.menu),
//           color: isDark ? tWhiteColor : tDarkColor),
//       title: Text(tAppName, style: Theme.of(context).textTheme.headlineMedium),
//     );
//   }
//
//   @override
//   // TODO: implement preferredSize
//   Size get preferredSize => const Size.fromHeight(55);
// }
