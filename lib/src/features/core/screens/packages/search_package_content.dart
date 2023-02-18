import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pony_logistics/src/features/core/controllers/google_sheets_controller.dart';
import 'package:pony_logistics/src/features/core/controllers/text_controller.dart';
import 'package:pony_logistics/src/features/core/screens/packages/update_package_screen.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../controllers/package_controller.dart';
import '../../models/dashboard/package_model.dart';
import '../dashboard/components/drawer_menu.dart';
import '../dashboard/components/responsive.dart';

class SearchPackageContent extends StatefulWidget {
  const SearchPackageContent({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchPackageContent();
  }
}

class _SearchPackageContent extends State<SearchPackageContent> {
  _SearchPackageContent() : super();
  String startDate =
      DateFormat('MM/dd/yyyy').format(DateTime(DateTime.now().year + 1, 2, 7));
  String endDate =
      DateFormat('MM/dd/yyyy').format(DateTime(DateTime.now().year + 1, 2, 7));
  String partNumber = "";
  bool isFilter = true;

  @override
  Widget build(BuildContext context) {
    // final packageController = Get.put(PackageController());
    final packageController = Get.put(GoogleSheetsController());
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? tPrimaryColor : tAccentColor;
    var textColor = isDark ? tPrimaryColor : tAccentColor;

    Future refresh() async {
      setState(() {});
    }

    DateTime findFirstDateOfTheWeek(DateTime dateTime) {
      return dateTime.subtract(Duration(days: dateTime.weekday - 1));
    }

    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            Expanded(
              child: DrawerMenu(),
            ),
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.all(tDefaultSize),

              /// -- Future Builder to load cloud data
              child: Column(
                children: [
                  Row(
                    children: [
                      if (!Responsive.isDesktop(context))
                        IconButton(
                          onPressed: () => Scaffold.of(context).openDrawer(),
                          icon: Icon(
                            Icons.menu,
                            color: textColor,
                          ),
                        ),
                      Expanded(
                        child: TextField(
                          controller: packageController.partNumber,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[0-9]')),
                          ],
                          decoration: InputDecoration(
                              label: const Text(tPartNumber),
                              prefixIcon:
                              const Icon(LineAwesomeIcons.slack_hashtag),
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      color: textColor, width: 1.0))),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          DateTimeRange? dateTimeRange =
                          await showDateRangePicker(
                            context: context,
                            initialDateRange: DateTimeRange(
                                start:
                                findFirstDateOfTheWeek(DateTime.now()),
                                end: DateTime.now()),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            builder: (context, child) => Theme(
                              data: ThemeData().copyWith(
                                  colorScheme: const ColorScheme.dark()),
                              child: child!,
                            ),
                          );
                          setState(() {
                            if(dateTimeRange != null) {
                              isFilter = true;
                              startDate = DateFormat('MM/dd/yyyy')
                                  .format(dateTimeRange.start);

                              endDate = DateFormat('MM/dd/yyyy')
                                  .format(dateTimeRange.end);
                            }
                          });
                        },
                        icon: const Icon(Icons.filter_list), hoverColor: transparent,),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: appPadding,
                          vertical: appPadding / 2,
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              child: Image.asset(
                                'assets/images/photo3.jpg',
                                height: 38,
                                width: 38,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<List<PackageModel>>(
                    future: isFilter
                    // ? googleSheetsController.getPackagesBetween(startDate, endDate)
                        ? packageController.getPackagesBetween(
                        startDate, endDate)
                        : packageController.getPackages(partNumber),
                    // : googleSheetsController.getPackages(partNumber),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Flexible(
                            child: RefreshIndicator(
                              onRefresh: refresh,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (c, index) {
                                    return Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(1),
                                          decoration: BoxDecoration(
                                              color: tPrimaryColor
                                                  .withOpacity(0.1),
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                              border: const Border(
                                                bottom: BorderSide(),
                                                top: BorderSide(),
                                                left: BorderSide(),
                                                right: BorderSide(),
                                              )),
                                          child: ListTile(
                                            leading: Container(
                                              padding:
                                              const EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: iconColor
                                                    .withOpacity(0.1),
                                              ),
                                              child: Icon(
                                                  LineAwesomeIcons.box,
                                                  color: iconColor),
                                            ),
                                            title: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "PN: ${snapshot.data![index].partNumber} "),
                                                Text(
                                                    "CNO: ${snapshot.data![index].caseNumber}"),
                                              ],
                                            ),
                                            subtitle: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "Q: ${snapshot.data![index].quantity} "),
                                                Text(
                                                    "DD: ${snapshot.data![index].dateDelivered}"),
                                              ],
                                            ),
                                            trailing: Container(
                                              padding:
                                              const EdgeInsets.all(1.0),
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      100),
                                                  color: iconColor
                                                      .withOpacity(0.1),
                                                ),
                                                child: IconButton(
                                                  onPressed: () => Get.to(
                                                        () => UpdatePackageScreen(
                                                        package: snapshot
                                                            .data![index]),
                                                    transition: Transition
                                                        .noTransition,
                                                  ),
                                                  icon: const Icon(
                                                      LineAwesomeIcons.edit),
                                                  color: iconColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text(snapshot.error.toString()));
                        } else {
                          return const Center(
                              child: Text('Something went wrong'));
                        }
                      } else {
                        return const Center(
                            child:
                            SizedBox(child: CircularProgressIndicator()));
                      }
                    },
                  ),
                ],
              ),

              // SearchPackages(),
            ),
          )
        ],
      ),
    );
  }
}
