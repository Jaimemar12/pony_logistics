// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
// import 'package:pony_logistics/src/features/core/controllers/package_controller.dart';
// import 'package:pony_logistics/src/features/core/models/dashboard/package_model.dart';
// import 'package:pony_logistics/src/features/core/screens/dashboard/dashboard.dart';
//
// import '../../../../constants/colors.dart';
// import '../../../../constants/sizes.dart';
// import '../../../../constants/text_strings.dart';
// import 'package:intl/intl.dart';
//
// class PackageUpdateScreen extends StatefulWidget {
//   var quantity;
//   var caseNumber;
//   var dateDelivered;
//   var partNumber;
//   var package;
//
//   PackageUpdateScreen({
//     Key? key,
//     required this.partNumber,
//     required this.caseNumber,
//     required this.quantity,
//     required this.dateDelivered,
//     required this.package,
//   }) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _PackageUpdateScreen(
//         partNumber: partNumber,
//         caseNumber: caseNumber,
//         quantity: quantity,
//         dateDelivered: dateDelivered,
//         package: package);
//   }
// }
//
// class _PackageUpdateScreen extends State<PackageUpdateScreen> {
//   _PackageUpdateScreen({
//     Key? key,
//     required this.partNumber,
//     required this.caseNumber,
//     required this.quantity,
//     required this.dateDelivered,
//     required this.package,
//   }) : super();
//
//   final TextEditingController partNumber;
//   final TextEditingController caseNumber;
//   final TextEditingController quantity;
//   final TextEditingController dateDelivered;
//   final PackageModel package;
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(PackageController());
//     final formKey = GlobalKey<FormState>();
//     var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
//     var textColor = isDark ? tPrimaryColor : tAccentColor;
//
//     return Form(
//       child: Column(
//         children: [
//           TextFormField(
//             key: formKey,
//             controller: partNumber,
//             keyboardType: const TextInputType.numberWithOptions(decimal: true),
//             inputFormatters: [
//               FilteringTextInputFormatter.allow(RegExp('[0-9]')),
//             ],
//             decoration: InputDecoration(
//                 label: const Text(tPartNumber),
//                 prefixIcon: const Icon(LineAwesomeIcons.slack_hashtag),
//                 border: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10.0))),
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//                     borderSide: BorderSide(color: textColor, width: 1.0))),
//           ),
//           const SizedBox(height: tFormHeight - 20),
//           TextFormField(
//             controller: caseNumber,
//             keyboardType: const TextInputType.numberWithOptions(decimal: true),
//             inputFormatters: [
//               FilteringTextInputFormatter.allow(RegExp('[0-9]')),
//             ],
//             decoration: InputDecoration(
//                 label: const Text(tCaseNumber),
//                 prefixIcon: const Icon(LineAwesomeIcons.slack_hashtag),
//                 border: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10.0))),
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//                     borderSide: BorderSide(color: textColor, width: 1.0))),
//           ),
//           const SizedBox(height: tFormHeight - 20),
//           TextFormField(
//             controller: quantity,
//             keyboardType: const TextInputType.numberWithOptions(decimal: true),
//             inputFormatters: [
//               FilteringTextInputFormatter.allow(RegExp('[0-9]')),
//             ],
//             decoration: InputDecoration(
//                 label: const Text(tQuantity),
//                 prefixIcon: const Icon(LineAwesomeIcons.slack_hashtag),
//                 border: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10.0))),
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//                     borderSide: BorderSide(color: textColor, width: 1.0))),
//           ),
//           const SizedBox(height: tFormHeight - 20),
//           TextFormField(
//             controller: dateDelivered,
//             readOnly: true,
//             decoration: InputDecoration(
//                 label: const Text(tDateDelivered),
//                 prefixIcon: const Icon(Icons.calendar_today),
//                 border: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10.0))),
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//                     borderSide: BorderSide(color: textColor, width: 1.0))),
//             onTap: () async {
//               DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime(2100));
//               if (pickedDate != null) {
//                 String formattedDate =
//                     DateFormat('MM-dd-yyyy').format(pickedDate);
//                 setState(() {
//                   dateDelivered.text =
//                       formattedDate; //set output date to TextField value.
//                 });
//               }
//             },
//           ),
//           const SizedBox(height: tFormHeight),
//
//           /// -- Form Submit Button
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () async {
//                 final packageData = PackageModel(
//                   id: package.id,
//                   partNumber: partNumber.text.trim(),
//                   caseNumber: caseNumber.text.trim(),
//                   quantity: quantity.text.trim(),
//                   dateDelivered: dateDelivered.text.trim(),
//                 );
//
//                 await controller.updateRecord(packageData);
//                 Get.to(() => const Dashboard());
//               },
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: tPrimaryColor,
//                   side: BorderSide.none,
//                   shape: const StadiumBorder()),
//               child: const Text(tUpdatePackage,
//                   style: TextStyle(color: tDarkColor)),
//             ),
//           ),
//           const SizedBox(height: tFormHeight),
//
//           /// -- Created Date and Delete Button
//           Align(
//             alignment: Alignment.centerRight,
//             child: ElevatedButton(
//               onPressed: () async {
//                 await controller.deletePackage(package);
//                 Get.to(() => const Dashboard());
//               },
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.redAccent.withOpacity(0.1),
//                   elevation: 0,
//                   foregroundColor: Colors.red,
//                   shape: const StadiumBorder(),
//                   side: BorderSide.none),
//               child: const Text(tDelete),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
