import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pony_logistics/src/features/core/models/dashboard/package_model.dart';
import 'package:pony_logistics/src/features/core/screens/packages/update_package_screen.dart';

import '../../../../../constants/colors.dart';
import '../../../controllers/google_sheets_controller.dart';
import '../../../controllers/package_controller.dart';

class TodayPackages extends StatefulWidget {
  const TodayPackages({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TodayPackages();
  }
}

class _TodayPackages extends State<TodayPackages> {
  _TodayPackages() : super();

  final controller = Get.put(GoogleSheetsController());

  Future refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? tPrimaryColor : tAccentColor;

    return FutureBuilder<List<PackageModel>>(
      future: controller.getTodayPackages(),
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
                                borderRadius: BorderRadius.circular(10.0),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "PN: ${snapshot.data![index].partNumber} "),
                                  Text(
                                      "CNO: ${snapshot.data![index].caseNumber}"),
                                ],
                              ),
                              subtitle: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Q: ${snapshot.data![index].quantity} "),
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
                                    borderRadius: BorderRadius.circular(100),
                                    color: iconColor.withOpacity(0.1),
                                  ),
                                  child: IconButton(
                                    onPressed: () => Get.to(
                                      () => UpdatePackageScreen(
                                          package: snapshot.data![index]),
                                      transition: Transition.noTransition,
                                    ),
                                    icon: const Icon(LineAwesomeIcons.edit),
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
    );
  }
}
