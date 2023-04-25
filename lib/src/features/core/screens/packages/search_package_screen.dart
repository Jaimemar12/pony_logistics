import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pony_logistics/src/features/core/controllers/google_sheets_controller.dart';
import 'package:pony_logistics/src/features/core/controllers/profile_controller.dart';
import 'package:pony_logistics/src/features/core/controllers/text_controller.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/submit_package_screen.dart';
import 'package:pony_logistics/src/features/core/screens/packages/update_package_screen.dart';
import 'package:pony_logistics/src/repository/user_repository/user_repository.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../models/dashboard/package_model.dart';
import '../dashboard/components/drawer_menu.dart';
import '../dashboard/components/responsive.dart';

class SearchPackageScreen extends StatefulWidget {
  SearchPackageScreen(this.partNumber, this.startDate, this.endDate, {Key? key})
      : super(key: key);
  String partNumber;
  String startDate;
  String endDate;

  @override
  State<StatefulWidget> createState() {
    return _SearchPackageScreen(partNumber, startDate, endDate);
  }
}

class _SearchPackageScreen extends State<SearchPackageScreen> {
  _SearchPackageScreen(this.partNumber, this.startDate, this.endDate) : super();
  String startDate;
  String endDate;
  String partNumber;
  bool rebuild = true;
  final packageController = GoogleSheetsController();
  late String? userName;
  late Future<List<PackageModel>> between;
  late Future<List<PackageModel>> packages;

  Future refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? tPrimaryColor : tAccentColor;
    var textColor = isDark ? tPrimaryColor : tAccentColor;

    getFuture() {
      if (rebuild) {
        UserController().getUserName().then((value) => setState((){
          userName = value;
          Future.delayed(const Duration(seconds: 2));
        }));
        setState(() {
          between = (startDate == "" || endDate == "")
              ? packageController.getPackagesBetween(
                  DateFormat('MM/dd/yyyy')
                      .format(DateTime(DateTime.now().year + 1, 2, 7)),
                  DateFormat('MM/dd/yyyy')
                      .format(DateTime(DateTime.now().year + 1, 2, 7)))
              : packageController.getPackagesBetween(startDate, endDate);
          packages = partNumber == ""
              ? packageController.getPackages("1")
              : packageController.getPackages(partNumber);
          rebuild = false;
        });
      }
      return partNumber == "" ? between : packages;
    }

    DateTime findFirstDateOfTheWeek(DateTime dateTime) {
      return dateTime.subtract(Duration(days: dateTime.weekday - 1));
    }

    return Scaffold(
      backgroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? tAccentColor
              : tPrimaryColor,
      drawer: const DrawerMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: DrawerMenu(),
              ),
            Expanded(
              flex: 5,
              child: FutureBuilder<List<PackageModel>>(
                future: getFuture(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List<PackageModel>? result = snapshot.data;

                      return SafeArea(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(appPadding),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  if (!Responsive.isDesktop(context))
                                    IconButton(
                                      onPressed: () =>
                                          Scaffold.of(context).openDrawer(),
                                      icon: Icon(
                                        Icons.menu,
                                        color: textColor,
                                      ),
                                    ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: packageController.partNumber,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      textInputAction: TextInputAction.go,
                                      onFieldSubmitted: (value) {
                                        setState(() {
                                          partNumber = value;
                                          rebuild = true;
                                        });
                                        refresh();
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]')),
                                      ],
                                      decoration: InputDecoration(
                                          label: Text(tPartNumber),
                                          prefixIcon: Icon(
                                            LineAwesomeIcons.slack_hashtag,
                                            color: textColor,
                                          ),
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                  color: textColor,
                                                  width: 1.0))),
                                    ),
                                  ),
                                  IconButton(
                                      hoverColor: Colors.transparent,
                                      onPressed: () {
                                        setState(() {
                                          rebuild = true;
                                          partNumber = packageController
                                              .partNumber.value.text;
                                        });
                                        refresh();
                                      },
                                      icon: Icon(
                                        LineAwesomeIcons.search,
                                        color: textColor,
                                      )),
                                  IconButton(
                                      onPressed: () async {
                                        DateTimeRange? dateTimeRange =
                                            await showDateRangePicker(
                                          context: context,
                                          initialDateRange: DateTimeRange(
                                              start: findFirstDateOfTheWeek(
                                                  DateTime.now()),
                                              end: DateTime.now()),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2100),
                                          builder: (context, child) => Theme(
                                            data: ThemeData().copyWith(
                                                colorScheme:
                                                    const ColorScheme.dark()),
                                            child: child!,
                                          ),
                                        );
                                        setState(() {
                                          rebuild = true;
                                          partNumber = "";
                                          startDate = DateFormat('MM/dd/yyyy')
                                              .format(dateTimeRange!.start);
                                          endDate = DateFormat('MM/dd/yyyy')
                                              .format(dateTimeRange.end);
                                        });
                                        refresh();
                                      },
                                      icon: Icon(
                                        Icons.filter_list,
                                        color: textColor,
                                      )),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: appPadding,
                                      vertical: appPadding / 2,
                                    ),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Image.asset(
                                            'assets/images/photo3.jpg',
                                            height: 38,
                                            width: 38,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        if (!Responsive.isMobile(context))
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: appPadding / 2),
                                            child: Text(
                                              'Hi, $userName',
                                              style: TextStyle(
                                                color: textColor,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  controller: scrollController,
                                  shrinkWrap: true,
                                  itemCount: result?.length,
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
                                                color:
                                                    iconColor.withOpacity(0.1),
                                              ),
                                              child: Icon(LineAwesomeIcons.box,
                                                  color: iconColor),
                                            ),
                                            title: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "PN: ${result?[index].partNumber} "),
                                                Text(
                                                    "CNO: ${result?[index].caseNumber}"),
                                              ],
                                            ),
                                            subtitle: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "Q: ${result?[index].quantity} "),
                                                Text(
                                                    "DD: ${result?[index].dateReceived}"),
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
                                                    () => SubmitPackageScreen(
                                                        result![index]),
                                                    transition:
                                                        Transition.noTransition,
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
                                  })
                            ],
                          ),
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
            )
          ],
        ),
      ),
    );
  }
}
