// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
// import 'package:pony_logistics/src/features/core/screens/packages/update_package_screen.dart';
//
// import '../../../../constants/colors.dart';
// import '../../../../constants/sizes.dart';
// import '../../../../constants/text_strings.dart';
// import '../../controllers/google_sheets_controller.dart';
// import '../../models/dashboard/package_model.dart';
// import '../dashboard/components/drawer_menu.dart';
// import '../dashboard/components/responsive.dart';
// import '../menu/menu_screen.dart';
//
// class SearchPackageScreen extends StatefulWidget {
//   var value;
//
//   SearchPackageScreen(this.value, {Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _SearchPackageScreen(value);
//   }
// }
//
// class _SearchPackageScreen extends State<SearchPackageScreen> {
//   _SearchPackageScreen(value) : super();
//   String startDate =
//   DateFormat('MM/dd/yyyy').format(DateTime(DateTime.now().year + 1, 2, 7));
//   String endDate =
//   DateFormat('MM/dd/yyyy').format(DateTime(DateTime.now().year + 1, 2, 7));
//   String partNumber = "";
//   bool isFilter = true;
//   final packageController = GoogleSheetsController();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // final packageController = Get.put(PackageController());
//     var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
//     var iconColor = isDark ? tPrimaryColor : tAccentColor;
//     var textColor = isDark ? tPrimaryColor : tAccentColor;
//     final scrollController = ScrollController();
//
//     refresh() async {
//       print('Refreshed');
//       setState(() {});
//     }
//
//     DateTime findFirstDateOfTheWeek(DateTime dateTime) {
//       return dateTime.subtract(Duration(days: dateTime.weekday - 1));
//     }
//
//     return Scaffold(
//       backgroundColor:
//       MediaQuery.of(context).platformBrightness == Brightness.dark
//           ? tAccentColor
//           : tPrimaryColor,
//       drawer: const DrawerMenu(),
//       body: SafeArea(
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (Responsive.isDesktop(context))
//               const Expanded(
//                 child: DrawerMenu(),
//               ),
//             Expanded(
//               flex: 5,
//               child: SafeArea(
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.all(appPadding),
//                   child: FutureBuilder<List<PackageModel>>(
//                     future: isFilter
//                         ? packageController.getPackagesBetween(
//                         startDate, endDate)
//                     //     ? between
//                     //     : packages;
//                         : packageController.getPackages(partNumber),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.done) {
//                         if (snapshot.hasData) {
//                           List<PackageModel>? todayPackages = snapshot.data;
//                           return Flexible(
//                             child: ListView.builder(
//                                 scrollDirection: Axis.vertical,
//                                 controller: scrollController,
//                                 shrinkWrap: true,
//                                 itemCount: snapshot.data?.length,
//                                 itemBuilder: (c, index) {
//                                   if (Responsive.isMobile(context)) {
//                                     return Card(
//                                       color:
//                                       isDark ? tPrimaryColor : tAccentColor,
//                                       elevation: 0,
//                                       child: Row(
//                                         children: [
//                                           Expanded(
//                                             child: Container(
//                                                 decoration: BoxDecoration(
//                                                     color: iconColor
//                                                         .withOpacity(0.1),
//                                                     borderRadius:
//                                                     BorderRadius.circular(
//                                                         10.0),
//                                                     border: const Border(
//                                                       bottom: BorderSide(),
//                                                       top: BorderSide(),
//                                                       left: BorderSide(),
//                                                       right: BorderSide(),
//                                                     )),
//                                                 child: ListTile(
//                                                   leading: Container(
//                                                       height: double.infinity,
//                                                       padding:
//                                                       const EdgeInsets.all(
//                                                           6),
//                                                       decoration: BoxDecoration(
//                                                         shape: BoxShape.circle,
//                                                         color: isDark
//                                                             ? tPrimaryColor
//                                                             : tAccentColor,
//                                                       ),
//                                                       child: Icon(
//                                                           LineAwesomeIcons.box,
//                                                           color: iconColor)),
//                                                   title: AutoSizeText(
//                                                     'Part Number: ${todayPackages?[index].partNumber}\nCase Number: ${todayPackages?[index].caseNumber}\nQuantity: ${todayPackages?[index].quantity}\nDate Received: ${todayPackages?[index].dateDelivered}',
//                                                     maxLines: 7,
//                                                     minFontSize: 12,
//                                                     maxFontSize: 15,
//                                                     style: TextStyle(
//                                                         color: iconColor),
//                                                   ),
//                                                   minLeadingWidth: 0,
//                                                   // Text(
//                                                   //     "PN: ${todayPackages[index].partNumber} CNO: ${todayPackages[index].caseNumber} Q: ${todayPackages[index].quantity} DD: ${todayPackages[index].dateDelivered}"),
//                                                 )),
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                                 decoration: BoxDecoration(
//                                                     color: iconColor
//                                                         .withOpacity(0.1),
//                                                     borderRadius:
//                                                     BorderRadius.circular(
//                                                         10.0),
//                                                     border: const Border(
//                                                       bottom: BorderSide(),
//                                                       top: BorderSide(),
//                                                       left: BorderSide(),
//                                                       right: BorderSide(),
//                                                     )),
//                                                 child: ListTile(
//                                                   leading: Container(
//                                                       height: double.infinity,
//                                                       padding:
//                                                       const EdgeInsets.all(
//                                                           6),
//                                                       decoration: BoxDecoration(
//                                                         shape: BoxShape.circle,
//                                                         color: isDark
//                                                             ? tPrimaryColor
//                                                             : tAccentColor,
//                                                       ),
//                                                       child: Icon(
//                                                           LineAwesomeIcons.box,
//                                                           color: iconColor)),
//                                                   title: AutoSizeText(
//                                                     'Part Number: ${todayPackages?[index].partNumber}\nCase Number: ${todayPackages?[index].caseNumber}\nQuantity: ${todayPackages?[index].quantity}\nDate Received: ${todayPackages?[index].dateDelivered}',
//                                                     maxLines: 7,
//                                                     minFontSize: 12,
//                                                     maxFontSize: 15,
//                                                     style: TextStyle(
//                                                         color: iconColor),
//                                                   ),
//                                                   minLeadingWidth: 0,
//
//                                                   // Text(
//                                                   //     "PN: ${todayPackages[index].partNumber} CNO: ${todayPackages[index].caseNumber} Q: ${todayPackages[index].quantity} DD: ${todayPackages[index].dateDelivered}"),
//                                                 )),
//                                           ),
//                                           // Column(
//                                           //   children: [
//                                           //     Container(
//                                           //       decoration: BoxDecoration(
//                                           //           color: iconColor.withOpacity(0.1),
//                                           //           borderRadius: BorderRadius.circular(10.0),
//                                           //           border: const Border(
//                                           //             bottom: BorderSide(),
//                                           //             top: BorderSide(),
//                                           //             left: BorderSide(),
//                                           //             right: BorderSide(),
//                                           //           )),
//                                           //       child: ListTile(
//                                           //         leading: Container(
//                                           //             height: double.infinity,
//                                           //             padding: const EdgeInsets.all(6),
//                                           //             decoration: BoxDecoration(
//                                           //               shape: BoxShape.circle,
//                                           //               color: isDark
//                                           //                   ? tPrimaryColor
//                                           //                   : tAccentColor,
//                                           //             ),
//                                           //             child: Icon(LineAwesomeIcons.box,
//                                           //                 color: iconColor)),
//                                           //         title: AutoSizeText(
//                                           //           'Part Number: ${todayPackages[index].partNumber}\nCase Number: ${todayPackages[index].caseNumber}\nQuantity: ${todayPackages[index].quantity}\nDate Received: ${todayPackages[index].dateDelivered}',
//                                           //           maxLines: 6,
//                                           //           minFontSize: 12,
//                                           //           maxFontSize: 15,
//                                           //           style: TextStyle(color: iconColor),
//                                           //         ),
//                                           //         minLeadingWidth: 0,
//                                           //
//                                           //         // Text(
//                                           //         //     "PN: ${todayPackages[index].partNumber} CNO: ${todayPackages[index].caseNumber} Q: ${todayPackages[index].quantity} DD: ${todayPackages[index].dateDelivered}"),
//                                           //       ),
//                                           //     ),
//                                           //     const SizedBox(
//                                           //       height: 10,
//                                           //     )
//                                           //   ],
//                                           // ),
//                                         ],
//                                       ),
//                                     );
//                                   } else {
//                                     return Column(
//                                       children: [
//                                         Container(
//                                           decoration: BoxDecoration(
//                                               color: iconColor.withOpacity(0.1),
//                                               borderRadius:
//                                               BorderRadius.circular(10.0),
//                                               border: const Border(
//                                                 bottom: BorderSide(),
//                                                 top: BorderSide(),
//                                                 left: BorderSide(),
//                                                 right: BorderSide(),
//                                               )),
//                                           child: ListTile(
//                                             leading: Container(
//                                                 height: double.infinity,
//                                                 padding:
//                                                 const EdgeInsets.all(6),
//                                                 decoration: BoxDecoration(
//                                                   shape: BoxShape.circle,
//                                                   color: isDark
//                                                       ? tPrimaryColor
//                                                       : tAccentColor,
//                                                 ),
//                                                 child: Icon(
//                                                     LineAwesomeIcons.box,
//                                                     color: iconColor)),
//                                             title: AutoSizeText(
//                                               'Part Number: ${todayPackages?[index].partNumber}\nCase Number: ${todayPackages?[index].caseNumber}\nQuantity: ${todayPackages?[index].quantity}\nDate Received: ${todayPackages?[index].dateReceived}',
//                                               maxLines: 6,
//                                               minFontSize: 12,
//                                               maxFontSize: 15,
//                                               style:
//                                               TextStyle(color: iconColor),
//                                             ),
//                                             minLeadingWidth: 0,
//
//                                             // Text(
//                                             //     "PN: ${todayPackages[index].partNumber} CNO: ${todayPackages[index].caseNumber} Q: ${todayPackages[index].quantity} DD: ${todayPackages[index].dateDelivered}"),
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           height: 10,
//                                         )
//                                       ],
//                                     );
//                                   }
//                                 }),
//                           );
//                         } else if (snapshot.hasError) {
//                           return Center(child: Text(snapshot.error.toString()));
//                         } else {
//                           return const Center(
//                               child: Text('Something went wrong'));
//                         }
//                       } else {
//                         return const Center(
//                             child:
//                             SizedBox(child: CircularProgressIndicator()));
//                       }
//                     },
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
