import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pony_logistics/src/features/core/screens/packages/update_package_screen.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../controllers/package_controller.dart';
import '../../models/dashboard/package_model.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PackagesScreen();
  }
}

class _PackagesScreen extends State<PackagesScreen> {
  _PackagesScreen() : super();
  String startDate =
      DateFormat('MM-dd-yyyy').format(DateTime(DateTime.now().year + 1, 2, 7));
  String endDate =
      DateFormat('MM-dd-yyyy').format(DateTime(DateTime.now().year + 1, 2, 7));

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;
    final controller = Get.put(PackageController());
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? tPrimaryColor : tAccentColor;

    Future refresh() async {
      setState(() {});
    }

    DateTime findFirstDateOfTheWeek(DateTime dateTime) {
      return dateTime.subtract(Duration(days: dateTime.weekday - 1));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text(tPackages.toUpperCase(),
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Container(
        padding: const EdgeInsets.all(tDefaultSize),

        /// -- Future Builder to load cloud data
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  border: Border(left: BorderSide(width: 4))),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(tDashboardSearch,
                      style: txtTheme.displaySmall
                          ?.apply(color: Colors.grey.withOpacity(1))),
                  IconButton(
                      onPressed: () async {
                        DateTimeRange? dateTimeRange =
                            await showDateRangePicker(
                          context: context,
                          initialDateRange: DateTimeRange(
                              start: findFirstDateOfTheWeek(DateTime.now()),
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
                          startDate = DateFormat('MM-dd-yyyy')
                              .format(dateTimeRange!.start);

                          endDate = DateFormat('MM-dd-yyyy')
                              .format(dateTimeRange.end);
                        });
                        refresh();
                      },
                      icon: const Icon(Icons.filter_list))
                ],
              ),
            ),
            FutureBuilder<List<PackageModel>>(
              future: controller.getPackagesBetween(startDate, endDate),
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
                                        color: tPrimaryColor.withOpacity(0.1),
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
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: iconColor.withOpacity(0.1),
                                        ),
                                        child: Icon(LineAwesomeIcons.box,
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
                                        padding: const EdgeInsets.all(1.0),
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: iconColor.withOpacity(0.1),
                                          ),
                                          child: IconButton(
                                            onPressed: () => Get.to(() =>
                                                UpdatePackageScreen(
                                                    snapshot.data![index])),
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
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return const Center(child: Text('Something went wrong'));
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),

        // SearchPackages(),
      ),
    );
  }
}
