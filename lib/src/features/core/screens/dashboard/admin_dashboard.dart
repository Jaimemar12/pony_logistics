import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/reports_screen.dart';
import 'package:pony_logistics/src/features/core/screens/packages/search_package_screen.dart';
import 'package:pony_logistics/src/repository/google_sheets_repository/google_sheets_repository.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../controllers/google_sheets_controller.dart';
import 'components/today_packages.dart';
import 'components/drawer_menu.dart';
import 'components/responsive.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pony_logistics/src/features/core/controllers/profile_controller.dart';
import 'package:pony_logistics/src/features/core/models/dashboard/package_model.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/components/statistics.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AdminDashboard();
  }
}

class _AdminDashboard extends State<AdminDashboard> {
  _AdminDashboard() : super();

  late Future<List<PackageModel>> data;
  final weekData = _createRandomData(DateTime.now().year);

  Future<List<PackageModel>> getPackages() async {
    return await packageController.getTodayPackages();
  }

  static List<WeekData> _createRandomData(int year) {
    print('Refreshed Graph');
    final random = Random();
    final firstDayOfYear = DateTime(year, 1, 1);
    final firstMondayOfYear = firstDayOfYear.weekday == 1
        ? firstDayOfYear
        : firstDayOfYear.add(Duration(days: 8 - firstDayOfYear.weekday));
    final weekData = List<WeekData>.generate(54, (index) {
      final weekStartDate = firstMondayOfYear.add(Duration(days: index * 7));
      final weekLabel = 'W${index + 1}';
      final dateLabel = '${weekStartDate.day}/${weekStartDate.month}';
      final weekValue = random.nextInt(100);
      return WeekData(weekLabel, dateLabel, weekValue);
    });
    return weekData;
  }

  @override
  void initState() {
    data = getPackages();
    super.initState();
  }

  final packageController = GoogleSheetsController();

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var textColor = isDark ? tPrimaryColor : tAccentColor;
    var columnColor = !isDark ? tPrimaryColor : tAccentColor;
    Get.put(GoogleSheetsRepository());

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
                future: data,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List<PackageModel> packages = snapshot.data!;

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
                                        Get.to(
                                            () => SearchPackageScreen(
                                                value, "", ""),
                                            transition:
                                                Transition.noTransition);
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
                                          data = getPackages();
                                        });
                                      },
                                      icon: Icon(
                                        LineAwesomeIcons.alternate_redo,
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
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: appPadding,
                              ),
                              Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context).size.height - 100,
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(appPadding),
                                              decoration: BoxDecoration(
                                                color: isDark ? tPrimaryColor : tAccentColor,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${DateTime.now().year} TOTAL PACKAGES PER WEEK",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 15,
                                                          color: textColor,
                                                        ),
                                                      ),
                                                      Expanded(child: SizedBox()),
                                                        IconButton(
                                                            onPressed: () => Get.to(() => ReportsScreen(),
                                                                transition: Transition.noTransition),
                                                            icon: Icon(
                                                              LineAwesomeIcons.expand,
                                                              color: textColor,
                                                            )),
                                                    ],
                                                  ),
                                                  Expanded(
                                                    child: SfCartesianChart(
                                                      primaryXAxis: CategoryAxis(
                                                          labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                                                          majorGridLines: const MajorGridLines(width: 0),
                                                          labelStyle: TextStyle(color: columnColor)),
                                                      primaryYAxis: NumericAxis(
                                                        labelStyle: TextStyle(color: columnColor),
                                                        majorGridLines: const MajorGridLines(width: 0),
                                                      ),
                                                      zoomPanBehavior: ZoomPanBehavior(
                                                        enableDoubleTapZooming: true,
                                                        enablePinching: true,
                                                        enableMouseWheelZooming: true,
                                                        enablePanning: true,
                                                        zoomMode: ZoomMode.xy,
                                                        maximumZoomLevel: Responsive.isMobile(context) ? .1 : .5,
                                                      ),
                                                      series: <ChartSeries>[
                                                        ColumnSeries<WeekData, String>(
                                                          dataSource: weekData,
                                                          xValueMapper: (WeekData week, _) =>
                                                          '${week.weekLabel}\n${week.weekDate}',
                                                          yValueMapper: (WeekData week, _) => week.weekValue,
                                                          pointColorMapper: (WeekData week, _) => columnColor,
                                                          dataLabelSettings: DataLabelSettings(
                                                            isVisible: true,
                                                            labelAlignment: ChartDataLabelAlignment.middle,
                                                          ),
                                                        )
                                                      ],
                                                      tooltipBehavior: TooltipBehavior(
                                                        textStyle: TextStyle(color: textColor),
                                                        color: columnColor.withOpacity(.5),
                                                        enable: true,
                                                        header: '',
                                                        format: 'point.x\npoint.y',
                                                        textAlignment: ChartAlignment.center,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            if (Responsive.isMobile(context))
                                              const SizedBox(
                                                height: appPadding,
                                              ),
                                            if (Responsive.isMobile(context))
                                              TodayPackages(packages),
                                          ],
                                        ),
                                      ),
                                      if (!Responsive.isMobile(context))
                                        const SizedBox(
                                          width: appPadding,
                                        ),
                                      if (!Responsive.isMobile(context))
                                        Expanded(
                                          flex: 2,
                                          child: TodayPackages(packages),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: appPadding, right: appPadding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Unable to Retrieve Data',
                                textAlign: TextAlign.center,
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(() => AdminDashboard(),
                                      transition: Transition.noTransition);
                                },
                                child: Text('Return home'),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: appPadding, right: appPadding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Something Went Wrong',
                                textAlign: TextAlign.center,
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(() => AdminDashboard(),
                                      transition: Transition.noTransition);
                                },
                                child: Text('Return home'),
                              ),
                            ],
                          ),
                        ),
                      );
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
