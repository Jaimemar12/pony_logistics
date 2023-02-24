import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pony_logistics/src/features/core/models/dashboard/package_model.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/components/responsive.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/sizes.dart';

class Discussions extends StatelessWidget {
  final List<PackageModel> packages;

  const Discussions(this.packages, {Key? key}) : super(key: key);

  List<PackageModel> getTodayPackages(List<PackageModel> packages) {
    var dateFormat = DateFormat('MM/dd/yyyy');
    var filteredPackages = <PackageModel>[];

    for (int i = 0; i < packages.length; i++) {
      var date = DateFormat('MM/dd/yyyy')
          .format(dateFormat.parse(packages[i].dateReceived))
          .toString();
      var todayDate =
          DateFormat('MM/dd/yyyy').format(DateTime.now()).toString();
      if (date == todayDate) {
        filteredPackages.add(packages[i]);
      }
    }
    return filteredPackages;
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = !isDark ? tPrimaryColor : tAccentColor;
    List<PackageModel> todayPackages = getTodayPackages(packages);
    final scrollController = ScrollController();

    return Container(
      height: 540,
      padding: const EdgeInsets.all(appPadding),
      decoration: BoxDecoration(
        color: isDark ? tPrimaryColor : tAccentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today\'s Packages',
                style: TextStyle(
                  color: iconColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              Text(
                'View All',
                style: TextStyle(
                  color: iconColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Flexible(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                controller: scrollController,
                shrinkWrap: true,
                itemCount: todayPackages.length,
                itemBuilder: (c, index) {
                  if (Responsive.isMobile(context)) {
                    return Card(
                      color: isDark ? tPrimaryColor : tAccentColor,
                      elevation: 0,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: iconColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: const Border(
                                      bottom: BorderSide(),
                                      top: BorderSide(),
                                      left: BorderSide(),
                                      right: BorderSide(),
                                    )),
                                child: ListTile(
                                  leading: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isDark
                                            ? tPrimaryColor
                                            : tAccentColor,
                                      ),
                                      child: Icon(LineAwesomeIcons.box,
                                          color: iconColor)),
                                  title: AutoSizeText(
                                    'Part Number: ${todayPackages[index].partNumber}\nCase Number: ${todayPackages[index].caseNumber}\nQuantity: ${todayPackages[index].quantity}\nDate Received: ${todayPackages[index].dateDelivered}',
                                    maxLines: 7,
                                    minFontSize: 12,
                                    maxFontSize: 15,
                                    style: TextStyle(color: iconColor),
                                  ),
                                  minLeadingWidth: 0,
                                  // Text(
                                  //     "PN: ${todayPackages[index].partNumber} CNO: ${todayPackages[index].caseNumber} Q: ${todayPackages[index].quantity} DD: ${todayPackages[index].dateDelivered}"),
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: iconColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: const Border(
                                      bottom: BorderSide(),
                                      top: BorderSide(),
                                      left: BorderSide(),
                                      right: BorderSide(),
                                    )),
                                child: ListTile(
                                  leading: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isDark
                                            ? tPrimaryColor
                                            : tAccentColor,
                                      ),
                                      child: Icon(LineAwesomeIcons.box,
                                          color: iconColor)),
                                  title: AutoSizeText(
                                    'Part Number: ${todayPackages[index].partNumber}\nCase Number: ${todayPackages[index].caseNumber}\nQuantity: ${todayPackages[index].quantity}\nDate Received: ${todayPackages[index].dateDelivered}',
                                    maxLines: 7,
                                    minFontSize: 12,
                                    maxFontSize: 15,
                                    style: TextStyle(color: iconColor),
                                  ),
                                  minLeadingWidth: 0,

                                  // Text(
                                  //     "PN: ${todayPackages[index].partNumber} CNO: ${todayPackages[index].caseNumber} Q: ${todayPackages[index].quantity} DD: ${todayPackages[index].dateDelivered}"),
                                )),
                          ),
                          // Column(
                          //   children: [
                          //     Container(
                          //       decoration: BoxDecoration(
                          //           color: iconColor.withOpacity(0.1),
                          //           borderRadius: BorderRadius.circular(10.0),
                          //           border: const Border(
                          //             bottom: BorderSide(),
                          //             top: BorderSide(),
                          //             left: BorderSide(),
                          //             right: BorderSide(),
                          //           )),
                          //       child: ListTile(
                          //         leading: Container(
                          //             height: double.infinity,
                          //             padding: const EdgeInsets.all(6),
                          //             decoration: BoxDecoration(
                          //               shape: BoxShape.circle,
                          //               color: isDark
                          //                   ? tPrimaryColor
                          //                   : tAccentColor,
                          //             ),
                          //             child: Icon(LineAwesomeIcons.box,
                          //                 color: iconColor)),
                          //         title: AutoSizeText(
                          //           'Part Number: ${todayPackages[index].partNumber}\nCase Number: ${todayPackages[index].caseNumber}\nQuantity: ${todayPackages[index].quantity}\nDate Received: ${todayPackages[index].dateDelivered}',
                          //           maxLines: 6,
                          //           minFontSize: 12,
                          //           maxFontSize: 15,
                          //           style: TextStyle(color: iconColor),
                          //         ),
                          //         minLeadingWidth: 0,
                          //
                          //         // Text(
                          //         //     "PN: ${todayPackages[index].partNumber} CNO: ${todayPackages[index].caseNumber} Q: ${todayPackages[index].quantity} DD: ${todayPackages[index].dateDelivered}"),
                          //       ),
                          //     ),
                          //     const SizedBox(
                          //       height: 10,
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: iconColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.0),
                              border: const Border(
                                bottom: BorderSide(),
                                top: BorderSide(),
                                left: BorderSide(),
                                right: BorderSide(),
                              )),
                          child: ListTile(
                            leading: Container(
                                height: double.infinity,
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isDark ? tPrimaryColor : tAccentColor,
                                ),
                                child: Icon(LineAwesomeIcons.box,
                                    color: iconColor)),
                            title: AutoSizeText(
                              'Part Number: ${todayPackages[index].partNumber}\nCase Number: ${todayPackages[index].caseNumber}\nQuantity: ${todayPackages[index].quantity}\nDate Received: ${todayPackages[index].dateReceived}',
                              maxLines: 6,
                              minFontSize: 12,
                              maxFontSize: 15,
                              style: TextStyle(color: iconColor),
                            ),
                            minLeadingWidth: 0,

                            // Text(
                            //     "PN: ${todayPackages[index].partNumber} CNO: ${todayPackages[index].caseNumber} Q: ${todayPackages[index].quantity} DD: ${todayPackages[index].dateDelivered}"),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
