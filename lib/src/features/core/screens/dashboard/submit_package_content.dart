// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
// import 'package:pony_logistics/src/constants/sizes.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../../../../constants/colors.dart';
// import '../../../../constants/text_strings.dart';
// import '../../controllers/google_sheets_controller.dart';
// import '../../models/dashboard/package_model.dart';
// import 'components/responsive.dart';
//
// class SubmitPackageContent extends StatefulWidget {
//   const SubmitPackageContent({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _SubmitPackageContent();
//   }
// }
//
// class _SubmitPackageContent extends State<SubmitPackageContent> {
//   _SubmitPackageContent() : super();
//
//   // final packageController = Get.put(PackageController());
//   final packageController = Get.put(GoogleSheetsController());
//   final formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
//     var iconColor = isDark ? tPrimaryColor : tAccentColor;
//     var textColor = isDark ? tPrimaryColor : tAccentColor;
//
//     return SafeArea(
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(appPadding),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: Responsive.isDesktop(context)
//                   ? MainAxisAlignment.end
//                   : MainAxisAlignment.spaceBetween,
//               children: [
//                 if (!Responsive.isDesktop(context))
//                   IconButton(
//                     onPressed: () => Scaffold.of(context).openDrawer(),
//                     icon: Icon(
//                       Icons.menu,
//                       color: textColor,
//                     ),
//                   ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: appPadding,
//                     vertical: appPadding / 2,
//                   ),
//                   child: Row(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(30),
//                         child: Image.asset(
//                           'assets/images/photo3.jpg',
//                           height: 38,
//                           width: 38,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             Form(
//               key: formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextFormField(
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "";
//                       } else {
//                         return null;
//                       }
//                     },
//                     textInputAction: TextInputAction.next,
//                     controller: packageController.containerName,
//                     decoration: InputDecoration(
//                         errorStyle: const TextStyle(height: 0),
//                         label: const Text('Container Name'),
//                         prefixIcon: Icon(
//                           LineAwesomeIcons.slack_hashtag,
//                           color: iconColor,
//                         ),
//                         border: const OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0))),
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(10.0)),
//                             borderSide:
//                                 BorderSide(color: textColor, width: 1.0))),
//                   ),
//                   const SizedBox(height: tFormHeight - 20),
//                   TextFormField(
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "";
//                       } else {
//                         return null;
//                       }
//                     },
//                     textInputAction: TextInputAction.next,
//                     controller: packageController.partNumber,
//                     keyboardType:
//                         const TextInputType.numberWithOptions(decimal: true),
//                     inputFormatters: [
//                       FilteringTextInputFormatter.allow(RegExp('[0-9]')),
//                     ],
//                     decoration: InputDecoration(
//                         errorStyle: const TextStyle(height: 0),
//                         label: const Text(tPartNumber),
//                         prefixIcon: Icon(
//                           LineAwesomeIcons.slack_hashtag,
//                           color: iconColor,
//                         ),
//                         border: const OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0))),
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(10.0)),
//                             borderSide:
//                                 BorderSide(color: textColor, width: 1.0))),
//                   ),
//                   const SizedBox(height: tFormHeight - 20),
//                   TextFormField(
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "";
//                       } else {
//                         return null;
//                       }
//                     },
//                     textInputAction: TextInputAction.next,
//                     controller: packageController.caseNumber,
//                     keyboardType:
//                         const TextInputType.numberWithOptions(decimal: true),
//                     inputFormatters: [
//                       FilteringTextInputFormatter.allow(RegExp('[0-9]')),
//                     ],
//                     decoration: InputDecoration(
//                         errorStyle: const TextStyle(height: 0),
//                         label: const Text(tCaseNumber),
//                         prefixIcon: Icon(
//                           LineAwesomeIcons.slack_hashtag,
//                           color: iconColor,
//                         ),
//                         border: const OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0))),
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(10.0)),
//                             borderSide:
//                                 BorderSide(color: textColor, width: 1.0))),
//                   ),
//                   const SizedBox(height: tFormHeight - 20),
//                   TextFormField(
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "";
//                       } else {
//                         return null;
//                       }
//                     },
//                     textInputAction: TextInputAction.next,
//                     controller: packageController.quantity,
//                     keyboardType:
//                         const TextInputType.numberWithOptions(decimal: true),
//                     inputFormatters: [
//                       FilteringTextInputFormatter.allow(RegExp('[0-9]')),
//                     ],
//                     decoration: InputDecoration(
//                         errorStyle: const TextStyle(height: 0),
//                         label: const Text(tQuantity),
//                         prefixIcon: Icon(
//                           LineAwesomeIcons.slack_hashtag,
//                           color: iconColor,
//                         ),
//                         border: const OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0))),
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(10.0)),
//                             borderSide:
//                                 BorderSide(color: textColor, width: 1.0))),
//                   ),
//                   const SizedBox(height: tFormHeight - 20),
//                   TextFormField(
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "";
//                       } else {
//                         return null;
//                       }
//                     },
//                     controller: packageController.dateReceived,
//                     readOnly: true,
//                     decoration: InputDecoration(
//                         errorStyle: const TextStyle(height: 0),
//                         label: const Text(tDateDelivered),
//                         prefixIcon: Icon(
//                           Icons.calendar_today,
//                           color: iconColor,
//                         ),
//                         border: const OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0))),
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(10.0)),
//                             borderSide:
//                                 BorderSide(color: textColor, width: 1.0))),
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(2000),
//                           lastDate: DateTime(2100));
//                       if (pickedDate != null) {
//                         String formattedDate =
//                             DateFormat('MM/dd/yyyy').format(pickedDate);
//                         setState(() {
//                           packageController.dateReceived.text =
//                               formattedDate; //set output date to TextField value.
//                         });
//                       }
//                     },
//                   ),
//                   const SizedBox(height: tFormHeight - 10),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         if (formKey.currentState!.validate()) {
//                           final package = PackageModel(
//                               containerName:
//                                   packageController.containerName.text.trim(),
//                               partNumber:
//                                   packageController.partNumber.text.trim(),
//                               caseNumber:
//                                   packageController.caseNumber.text.trim(),
//                               quantity: packageController.quantity.text.trim(),
//                               dateReceived:
//                                   packageController.dateReceived.text.trim(),
//                               dateShipped: 'null',
//                               dateDelivered: 'null',
//                               trailerNumber: 'null',
//                               status: 'Available');
//
//                           // await googleSheetsController.createPackage(package);
//                           await packageController.createPackage(package);
//                           setState(() {
//                             packageController.containerName.text = "";
//                             packageController.partNumber.text = "";
//                             packageController.caseNumber.text = "";
//                             packageController.quantity.text = "";
//                             packageController.dateReceived.text = "";
//                           });
//                         }
//                       },
//                       child: Text(tSubmit.toUpperCase()),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
