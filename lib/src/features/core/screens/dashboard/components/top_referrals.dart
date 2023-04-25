// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:pony_logistics/src/features/core/screens/dashboard/components/referral_info_detail.dart';
//
// import '../../../../../constants/colors.dart';
// import '../../../../../constants/sizes.dart';
// import '../data/data.dart';
//
// class TopReferrals extends StatelessWidget {
//   const TopReferrals({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
//     var textColor = !isDark ? tPrimaryColor : tAccentColor;
//
//     return Container(
//       height: 350,
//       padding: const EdgeInsets.all(appPadding),
//       decoration: BoxDecoration(
//         color: isDark ? tPrimaryColor : tAccentColor,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'TopReferrals',
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w700,
//                   color: textColor,
//                 ),
//               ),
//               Text(
//                 'View All',
//                 style: TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.bold,
//                   color: textColor,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: appPadding,
//           ),
//           Expanded(
//             child: ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: referalData.length,
//               itemBuilder: (context, index) => ReferralInfoDetail(
//                 info: referalData[index],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
