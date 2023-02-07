import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pony_logistics/src/features/core/models/dashboard/package_model.dart';

import '../../../../../constants/colors.dart';
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

  final controller = Get.put(PackageController());

  Future refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PackageModel>>(
      future: controller.getTodaysPackages(),
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
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: tAccentColor,
                                ),
                                child: const Icon(LineAwesomeIcons.box,
                                    color: Colors.black),
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
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    LineAwesomeIcons.edit,
                                    color: tAccentColor,
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
