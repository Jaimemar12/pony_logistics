// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pony_logistics/src/features/core/screens/packages/packages_screen.dart';
// import 'package:pony_logistics/src/features/core/screens/packages/widgets/search_packages.dart';
//
// import 'package:intl/intl.dart';
// import '../../../../../constants/text_strings.dart';
//
// class PackagesSearchBox extends StatelessWidget {
//   const PackagesSearchBox({
//     Key? key,
//     required this.txtTheme,
//   }) : super(key: key);
//
//   final TextTheme txtTheme;
//   static String startDate = DateFormat('MM-dd-yyyy').format(DateTime(DateTime.now().year+1, 2, 7));
//   static String endDate = DateFormat('MM-dd-yyyy').format(DateTime(DateTime.now().year+1, 2, 7));
//
//   @override
//   Widget build(BuildContext context) {
//
//     DateTime findFirstDateOfTheWeek(DateTime dateTime) {
//       return dateTime.subtract(Duration(days: dateTime.weekday - 1));
//     }
//
//     return Container(
//       decoration:
//           const BoxDecoration(border: Border(left: BorderSide(width: 4))),
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(tDashboardSearch,
//               style: txtTheme.displaySmall
//                   ?.apply(color: Colors.grey.withOpacity(1))),
//           IconButton(
//               onPressed: () async {
//                 DateTimeRange? dateTimeRange = await showDateRangePicker(
//                     context: context,
//                     initialDateRange: DateTimeRange(
//                         start: findFirstDateOfTheWeek(DateTime.now()),
//                         end: DateTime.now()),
//                     firstDate: DateTime(2000),
//                     lastDate: DateTime(2100),
//                     builder: (context, child) => Theme(
//                         data: ThemeData()
//                             .copyWith(colorScheme: ColorScheme.dark()),
//                         child: child!,),);
//                 startDate = DateFormat('MM-dd-yyyy').format(dateTimeRange!.start);
//                 endDate = DateFormat('MM-dd-yyyy').format(dateTimeRange!.end);
//               },
//               icon: const Icon(Icons.filter_list))
//         ],
//       ),
//     );
//   }
// }
