import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:promodoro/ColorPallets.dart';
import '../../ColorPallets.dart'; // Adjust the path as needed


class SessionGraph extends StatelessWidget {
  final List<double> efficiencies;

  const SessionGraph({super.key, required this.efficiencies});

  @override
  Widget build(BuildContext context) {
    final List<double> data = efficiencies.length > 10
        ? efficiencies.sublist(efficiencies.length - 10)
        : efficiencies;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.blackLight,
        borderRadius: BorderRadius.circular(15),
      ),
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Progress",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: AppColors.white1,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: BarChart(
                BarChartData(
                  maxY: 100,
                  minY: 0,
                  borderData: FlBorderData(
                    show: false,
                    border: const Border(
                      left: BorderSide(color: Colors.white24),
                      bottom: BorderSide(color: Colors.white24),
                    ),
                  ),
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 20,
                        getTitlesWidget: (value, _) => Text(
                          '${value.toInt()}%',
                          style: const TextStyle(color: Colors.white, fontSize: 10,fontFamily: "Montserrat",fontWeight: FontWeight.w500),
                        ),
                        reservedSize: 30,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) => Text(
                          'S${value.toInt() + 1}',
                          style: const TextStyle(color: Colors.white, fontSize: 10,fontFamily: "Montserrat",fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  barGroups: List.generate(data.length, (index) {
                    final value = data[index];
                    Color barColor;
                    if (value >= 70) {
                      barColor = AppColors.greenLight; // good
                    } else if (value >= 50) {
                      barColor = AppColors.violetLight; // moderate
                    } else {
                      barColor = AppColors.orangeDark; // poor
                    }
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: value,
                          color: barColor,
                          width: 16,
                          borderRadius: BorderRadius.circular(6),
                        )
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
