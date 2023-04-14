// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
// import 'package:pony_logistics/src/features/authentication/models/user_model.dart';
// import 'package:pony_logistics/src/features/core/controllers/profile_controller.dart';
// import 'package:pony_logistics/src/features/core/models/dashboard/package_model.dart';
// import 'package:pony_logistics/src/features/core/screens/dashboard/components/responsive.dart';
// import 'package:pony_logistics/src/features/core/screens/dashboard/components/top_referrals.dart';
// import 'package:pony_logistics/src/features/core/screens/dashboard/components/users.dart';
// import 'package:pony_logistics/src/features/core/screens/dashboard/components/users_by_device.dart';
// import 'package:pony_logistics/src/features/core/screens/dashboard/components/viewers.dart';
// import 'package:pony_logistics/src/features/core/screens/menu/menu_screen.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../../constants/colors.dart';
// import '../../../../../constants/sizes.dart';
// import '../../../../../constants/text_strings.dart';
// import '../../../controllers/google_sheets_controller.dart';
// import 'analytic_cards.dart';
// import 'today_packages.dart';
//
// class DashboardContent extends StatefulWidget {
//   const DashboardContent({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _DashboardContent();
//   }
// }
//
//
// class _DashboardContent extends State<DashboardContent> {
//   _DashboardContent() : super();
//
//
//   late Future<List<dynamic>> data;
//
//   Future<List<dynamic>> getList() async {
//     List<PackageModel> packages = await packageController.getAllPackages();
//     UserModel? user = await userController.getUserData();
//     var temp = [];
//     temp.add(packages);
//     temp.add(user);
//     return Future.value(temp);
//   }
//
//   refresh() {
//     data = Future.value(getList());
//     setState(() {});
//   }
//
//   @override
//   void initState() {
//     data = Future.value(getList());
//     super.initState();
//   }
//
//   final packageController = Get.put(GoogleSheetsController());
//   final userController = Get.put(ProfileController());
//
//   @override
//   Widget build(BuildContext context) {
//     var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
//     var textColor = isDark ? tPrimaryColor : tAccentColor;
//
//     return FutureBuilder<List<dynamic>>(
//       future: data,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasData) {
//             List<PackageModel> packages = snapshot.data![0];
//             UserModel user = snapshot.data![1];
//
//             return SafeArea(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(appPadding),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         if (!Responsive.isDesktop(context))
//                           IconButton(
//                             onPressed: () => Scaffold.of(context).openDrawer(),
//                             icon: Icon(
//                               Icons.menu,
//                               color: textColor,
//                             ),
//                           ),
//                         Expanded(
//                           child: TextFormField(
//                             controller: packageController.partNumber,
//                             keyboardType: const TextInputType.numberWithOptions(
//                                 decimal: true),
//                             textInputAction: TextInputAction.go,
//                             onFieldSubmitted: (value) {
//                               Get.to(() => const MenuScreen(),
//                                   transition: Transition.noTransition);
//                             },
//                             inputFormatters: [
//                               FilteringTextInputFormatter.allow(
//                                   RegExp('[0-9]')),
//                             ],
//                             decoration: InputDecoration(
//                                 label: const Text(tPartNumber),
//                                 prefixIcon:
//                                     const Icon(LineAwesomeIcons.slack_hashtag),
//                                 border: const OutlineInputBorder(
//                                     borderRadius: BorderRadius.all(
//                                         Radius.circular(10.0))),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(10.0)),
//                                     borderSide: BorderSide(
//                                         color: textColor, width: 1.0))),
//                           ),
//                         ),
//                         IconButton(
//                             hoverColor: Colors.transparent,
//                             onPressed: () {
//                               refresh();
//                             },
//                             icon: Icon(
//                               LineAwesomeIcons.alternate_redo,
//                               color: textColor,
//                             )),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: appPadding,
//                             vertical: appPadding / 2,
//                           ),
//                           child: Row(
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(30),
//                                 child: Image.asset(
//                                   'assets/images/photo3.jpg',
//                                   height: 38,
//                                   width: 38,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                               if (!Responsive.isMobile(context))
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: appPadding / 2),
//                                   child: Text(
//                                     'Hi, ${user.fullName}',
//                                     style: TextStyle(
//                                       color: textColor,
//                                       fontWeight: FontWeight.w800,
//                                     ),
//                                   ),
//                                 )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       height: appPadding,
//                     ),
//                     Column(
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 5,
//                               child: Column(
//                                 children: [
//                                   const AnalyticCards(),
//                                   const SizedBox(
//                                     height: appPadding,
//                                   ),
//                                   const Users(),
//                                   if (Responsive.isMobile(context))
//                                     const SizedBox(
//                                       height: appPadding,
//                                     ),
//                                   if (Responsive.isMobile(context))
//                                     Discussions(packages),
//                                 ],
//                               ),
//                             ),
//                             if (!Responsive.isMobile(context))
//                               const SizedBox(
//                                 width: appPadding,
//                               ),
//                             if (!Responsive.isMobile(context))
//                               Expanded(
//                                 flex: 2,
//                                 child: Discussions(packages),
//                               ),
//                           ],
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               flex: 5,
//                               child: Column(
//                                 children: [
//                                   const SizedBox(
//                                     height: appPadding,
//                                   ),
//                                   Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       if (!Responsive.isMobile(context))
//                                         const Expanded(
//                                           flex: 2,
//                                           child: TopReferrals(),
//                                         ),
//                                       if (!Responsive.isMobile(context))
//                                         const SizedBox(
//                                           width: appPadding,
//                                         ),
//                                       const Expanded(
//                                         flex: 3,
//                                         child: Viewers(),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                     height: appPadding,
//                                   ),
//                                   if (Responsive.isMobile(context))
//                                     const SizedBox(
//                                       height: appPadding,
//                                     ),
//                                   if (Responsive.isMobile(context))
//                                     const TopReferrals(),
//                                   if (Responsive.isMobile(context))
//                                     const SizedBox(
//                                       height: appPadding,
//                                     ),
//                                   if (Responsive.isMobile(context))
//                                     const UsersByDevice(),
//                                 ],
//                               ),
//                             ),
//                             if (!Responsive.isMobile(context))
//                               const SizedBox(
//                                 width: appPadding,
//                               ),
//                             if (!Responsive.isMobile(context))
//                               const Expanded(
//                                 flex: 2,
//                                 child: UsersByDevice(),
//                               ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Center(child: Text(snapshot.error.toString()));
//           } else {
//             return const Center(child: Text('Something went wrong'));
//           }
//         } else {
//           return const Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }
