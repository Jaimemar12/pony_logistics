import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../config/responsive.dart';
import '../style/colors.dart';

class BarChartCopmponent extends StatelessWidget {
  const BarChartCopmponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
          borderData: FlBorderData(show: false),
          alignment: BarChartAlignment.spaceBetween,
          gridData:
              FlGridData(drawHorizontalLine: true, horizontalInterval: 30),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 30,
                // getTextStyles: (value) =>
                // const TextStyle(color: Colors.grey, fontSize: 12),
                showTitles: true,
                // getTitlesWidget: (value) {
                //   if (value == 0) {
                //     return '0';
                //   } else if (value == 30) {
                //     return '30k';
                //   } else if (value == 60) {
                //     return '60k';
                //   } else if (value == 90) {
                //     return '90k';
                //   } else {
                //     return '';
                //   }
                // },
              )
            ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  // getTextStyles: (value) =>
                  // const TextStyle(color: Colors.grey, fontSize: 12),
                  // getTitles: (value) {
                  //   if (value == 0) {
                  //     return 'JAN';
                  //   } else if (value == 1) {
                  //     return 'FEB';
                  //   } else if (value == 2) {
                  //     return 'MAR';
                  //   } else if (value == 3) {
                  //     return 'APR';
                  //   } else if (value == 4) {
                  //     return 'MAY';
                  //   } else if (value == 5) {
                  //     return 'JUN';
                  //   } else if (value == 6) {
                  //     return 'JUL';
                  //   } else if (value == 7) {
                  //     return 'AUG';
                  //   } else if (value == 8) {
                  //     return 'SEP';
                  //   } else if (value == 9) {
                  //     return 'OCT';
                  //   } else if (value == 10) {
                  //     return 'NOV';
                  //   } else if (value == 11) {
                  //     return 'DEC';
                  //   } else {
                  //     return '';
                  //   }
                  // },
                )
              ),),
          barGroups: [
            BarChartGroupData(x: 0, barRods: [
              BarChartRodData(
                  fromY: 10,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(0),
                  width: Responsive.isDesktop(context) ? 40 : 10,
                  backDrawRodData: BackgroundBarChartRodData(
                      fromY: 90, show: true, color: AppColors.barBg), toY: 10),
            ]),
            BarChartGroupData(x: 1, barRods: [
              BarChartRodData(
                  fromY: 50,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(0),
                  width: Responsive.isDesktop(context) ? 40 : 10,
                  backDrawRodData: BackgroundBarChartRodData(
                      fromY: 90, show: true, color: AppColors.barBg), toY: 50)
            ]),
            BarChartGroupData(x: 2, barRods: [
              BarChartRodData(
                  fromY: 30,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(0),
                  width: Responsive.isDesktop(context) ? 40 : 10,
                  backDrawRodData: BackgroundBarChartRodData(
                      fromY: 90, show: true, color: AppColors.barBg), toY: 30)
            ]),
            BarChartGroupData(x: 3, barRods: [
              BarChartRodData(
                  fromY: 80,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(0),
                  width: Responsive.isDesktop(context) ? 40 : 10,
                  backDrawRodData: BackgroundBarChartRodData(
                      fromY: 90, show: true, color: AppColors.barBg), toY: 80)
            ]),
            BarChartGroupData(x: 4, barRods: [
              BarChartRodData(
                  fromY: 70,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(0),
                  width: Responsive.isDesktop(context) ? 40 : 10,
                  backDrawRodData: BackgroundBarChartRodData(
                      fromY: 90, show: true, color: AppColors.barBg), toY: 70)
            ]),
            BarChartGroupData(x: 5, barRods: [
              BarChartRodData(
                  fromY: 20,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(0),
                  width: Responsive.isDesktop(context) ? 40 : 10,
                  backDrawRodData: BackgroundBarChartRodData(
                      fromY: 90, show: true, color: AppColors.barBg), toY: 20)
            ]),
            BarChartGroupData(x: 6, barRods: [
              BarChartRodData(
                  fromY: 90,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(0),
                  width: Responsive.isDesktop(context) ? 40 : 10,
                  backDrawRodData: BackgroundBarChartRodData(
                      fromY: 90, show: true, color: AppColors.barBg), toY: 90)
            ]),
            BarChartGroupData(x: 7, barRods: [
              BarChartRodData(
                  fromY: 60,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(0),
                  width: Responsive.isDesktop(context) ? 40 : 10,
                  backDrawRodData: BackgroundBarChartRodData(
                      fromY: 90, show: true, color: AppColors.barBg), toY: 60)
            ]),
            BarChartGroupData(x: 8, barRods: [
              BarChartRodData(
                  fromY: 90,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(0),
                  width: Responsive.isDesktop(context) ? 40 : 10,
                  backDrawRodData: BackgroundBarChartRodData(
                      fromY: 90, show: true, color: AppColors.barBg), toY: 90)
            ]),
            BarChartGroupData(x: 9, barRods: [
              BarChartRodData(
                  fromY: 10,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(0),
                  width: Responsive.isDesktop(context) ? 40 : 10,
                  backDrawRodData: BackgroundBarChartRodData(
                      fromY: 90, show: true, color: AppColors.barBg), toY: 10)
            ]),
            BarChartGroupData(x: 10, barRods: [
              BarChartRodData(
                  fromY: 40,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(0),
                  width: Responsive.isDesktop(context) ? 40 : 10,
                  backDrawRodData: BackgroundBarChartRodData(
                      fromY: 90, show: true, color: AppColors.barBg), toY: 40)
            ]),
            BarChartGroupData(x: 11, barRods: [
              BarChartRodData(
                  fromY: 80,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(0),
                  width: Responsive.isDesktop(context) ? 40 : 10,
                  backDrawRodData: BackgroundBarChartRodData(
                      fromY: 90, show: true, color: AppColors.barBg), toY: 80,)
            ]),
          ]),
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear, // Optional
    );
  }
}
