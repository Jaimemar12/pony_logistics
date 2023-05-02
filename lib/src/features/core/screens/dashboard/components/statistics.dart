import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/components/responsive.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/reports_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';

import '../../../../../constants/colors.dart';
import '../../../../../constants/sizes.dart';

class Statistics extends StatelessWidget {
  Statistics(this.inScreen, {Key? key}) : super(key: key);
  bool inScreen;

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
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var textColor = !isDark ? tPrimaryColor : tAccentColor;
    final year = DateTime.now().year;
    final weekData = _createRandomData(year);

    return Container(
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
              if (!inScreen)
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
                  labelStyle: TextStyle(color: textColor)),
              primaryYAxis: NumericAxis(
                labelStyle: TextStyle(color: textColor),
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
                  pointColorMapper: (WeekData week, _) => textColor,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    labelAlignment: ChartDataLabelAlignment.middle,
                  ),
                )
              ],
              tooltipBehavior: TooltipBehavior(
                color: textColor,
                enable: true,
                header: '',
                format: 'point.x\npoint.y',
                textAlignment: ChartAlignment.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class WeekData {
  final String weekLabel;
  final String weekDate;
  final int weekValue;

  WeekData(this.weekLabel, this.weekDate, this.weekValue);
}
