import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pony_logistics/src/repository/report_repository/report_repository.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../controllers/google_sheets_controller.dart';
import 'components/drawer_menu.dart';
import 'components/responsive.dart';
import 'dart:async';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pony_logistics/src/features/core/models/dashboard/package_model.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/components/statistics.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ReportsScreen();
  }
}

class _ReportsScreen extends State<ReportsScreen> {
  _ReportsScreen() : super();
  TextEditingController packingSlipNumberController = TextEditingController();
  TextEditingController trailerNumberController = TextEditingController();
  TextEditingController carrierNameController = TextEditingController();
  final packageController = GoogleSheetsController();
  final reportRepository = ReportRepository();
  late Future<List<PackageModel>> data;
  final formKey = GlobalKey<FormState>();
  final weekData = _createRandomData(DateTime.now().year);

  Future<List<PackageModel>> getList() async {
    return await packageController.getAllPackages();
  }

  static List<WeekData> _createRandomData(int year) {
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
    data = getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? tPrimaryColor : tAccentColor;
    var textColor = isDark ? tPrimaryColor : tAccentColor;
    var columnColor = !isDark ? tPrimaryColor : tAccentColor;

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
                                  
                                  if(Responsive.isDesktop(context))
                                  Form(
                                      key: formKey,
                                      child: Flexible(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller:
                                                    packingSlipNumberController,
                                                keyboardType:
                                                    const TextInputType
                                                            .numberWithOptions(
                                                        decimal: false),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                    errorStyle: const TextStyle(
                                                        height: 0),
                                                    label: const Text(
                                                        tPackingSlipNumber),
                                                    prefixIcon: Icon(
                                                      LineAwesomeIcons
                                                          .slack_hashtag,
                                                      color: iconColor,
                                                    ),
                                                    border: const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0))),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        borderSide: BorderSide(
                                                            color: textColor,
                                                            width: 1.0))),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: TextFormField(
                                                textInputAction:
                                                TextInputAction.next,
                                                controller:
                                                trailerNumberController,
                                                keyboardType:
                                                const TextInputType
                                                    .numberWithOptions(
                                                    decimal: false),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                    errorStyle: const TextStyle(
                                                        height: 0),
                                                    label: const Text(
                                                        tTrailerNumber),
                                                    prefixIcon: Icon(
                                                      LineAwesomeIcons
                                                          .slack_hashtag,
                                                      color: iconColor,
                                                    ),
                                                    border: const OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0))),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        const BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                10.0)),
                                                        borderSide: BorderSide(
                                                            color: textColor,
                                                            width: 1.0))),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Expanded(
                                              child: TextFormField(
                                                textInputAction:
                                                    TextInputAction.go,
                                                onFieldSubmitted: (value) {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    setState(() {});
                                                  }
                                                },
                                                controller:
                                                    carrierNameController,
                                                keyboardType:
                                                    const TextInputType
                                                            .numberWithOptions(
                                                        decimal: false),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                    errorStyle: const TextStyle(
                                                        height: 0),
                                                    label: const Text(
                                                        tCarrierName),
                                                    prefixIcon: Icon(
                                                      LineAwesomeIcons
                                                          .slack_hashtag,
                                                      color: iconColor,
                                                    ),
                                                    border: const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0))),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        borderSide: BorderSide(
                                                            color: textColor,
                                                            width: 1.0))),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  if(!Responsive.isDesktop(context))
                                    Expanded(child: SizedBox())
                                    ,
                                  Tooltip(
                                    message: 'Generate Report',
                                    child: IconButton(
                                        alignment: Alignment.center,
                                        hoverColor: Colors.transparent,
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            await reportRepository.generateReport(
                                                packingSlipNumberController
                                                    .text,
                                                trailerNumberController.text,
                                            carrierNameController.text);
                                            packingSlipNumberController
                                                .text = "";
                                          trailerNumberController.text = "";
                                          carrierNameController.text = "";
                                          }
                                        },
                                        icon: Icon(
                                          LineAwesomeIcons.file_export,
                                          color: textColor,
                                          size: 30,
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              if(Responsive.isMobile(context))
                                Form(
                                    key: formKey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextFormField(
                                          textInputAction:
                                          TextInputAction.next,
                                          controller:
                                          packingSlipNumberController,
                                          keyboardType:
                                          const TextInputType
                                              .numberWithOptions(
                                              decimal: false),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                              errorStyle: const TextStyle(
                                                  height: 0),
                                              label: const Text(
                                                  tPackingSlipNumber),
                                              prefixIcon: Icon(
                                                LineAwesomeIcons
                                                    .slack_hashtag,
                                                color: iconColor,
                                              ),
                                              border: const OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(
                                                          10.0))),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  const BorderRadius
                                                      .all(
                                                      Radius.circular(
                                                          10.0)),
                                                  borderSide: BorderSide(
                                                      color: textColor,
                                                      width: 1.0))),
                                        ),
                                        const SizedBox(height: tFormHeight - 20),
                                        TextFormField(
                                          textInputAction:
                                          TextInputAction.next,
                                          controller:
                                          trailerNumberController,
                                          keyboardType:
                                          const TextInputType
                                              .numberWithOptions(
                                              decimal: false),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                              errorStyle: const TextStyle(
                                                  height: 0),
                                              label: const Text(
                                                  tTrailerNumber),
                                              prefixIcon: Icon(
                                                LineAwesomeIcons
                                                    .slack_hashtag,
                                                color: iconColor,
                                              ),
                                              border: const OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(
                                                          10.0))),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  const BorderRadius
                                                      .all(
                                                      Radius.circular(
                                                          10.0)),
                                                  borderSide: BorderSide(
                                                      color: textColor,
                                                      width: 1.0))),
                                        ),
                                        const SizedBox(height: tFormHeight - 20),
                                        TextFormField(
                                          textInputAction:
                                          TextInputAction.go,
                                          onFieldSubmitted: (value) {
                                            if (formKey.currentState!
                                                .validate()) {
                                              setState(() {});
                                            }
                                          },
                                          controller:
                                          carrierNameController,
                                          keyboardType:
                                          const TextInputType
                                              .numberWithOptions(
                                              decimal: false),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                              errorStyle: const TextStyle(
                                                  height: 0),
                                              label: const Text(
                                                  tCarrierName),
                                              prefixIcon: Icon(
                                                LineAwesomeIcons
                                                    .slack_hashtag,
                                                color: iconColor,
                                              ),
                                              border: const OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(
                                                          10.0))),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  const BorderRadius
                                                      .all(
                                                      Radius.circular(
                                                          10.0)),
                                                  borderSide: BorderSide(
                                                      color: textColor,
                                                      width: 1.0))),
                                        ),
                                        const SizedBox(height: tFormHeight - 20),
                                      ],
                                    )),
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
