import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fv_frontend_task/constants/app_colors.dart';

class LineChartSample2 extends StatelessWidget {
  const LineChartSample2({super.key});
  List<FlSpot> createGranularPoints() {
    List<FlSpot> points = [];

    // Original Points Data
    List<FlSpot> originalPoints = [
      FlSpot(0, 3),
      FlSpot(0.1, 2.9),
      FlSpot(2.6, 2),
      FlSpot(4.9, 5),
      FlSpot(6.8, 3.1),
      FlSpot(8, 4),
      FlSpot(9.5, 3),
      FlSpot(11, 4),
    ];

    // Adding Points
    for (int i = 0; i < originalPoints.length - 1; i++) {
      // Get current and next spot
      FlSpot current = originalPoints[i];
      FlSpot next = originalPoints[i + 1];

      // Calculate step increments
      double xIncrement = (next.x - current.x) / 20; // 20 steps between points
      double yIncrement = (next.y - current.y) / 20;

      // Add intermediate points
      for (int j = 0; j <= 20; j++) {
        double newX = current.x + xIncrement * j;
        double newY = current.y + yIncrement * j;
        points.add(FlSpot(newX, newY));
      }
    }

    // Add the last original point
    points.add(originalPoints.last);

    return points;
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: false,
          drawHorizontalLine: false,
          drawVerticalLine: true,
        ),
        titlesData: FlTitlesData(
          show: false,
        ),
        borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1),
        ),
        minX: 0,
        maxX: 10,
        minY: 0,
        maxY: 6,
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 3), // Start point
              const FlSpot(0.02, 2.98), // Granular change
              const FlSpot(0.04, 2.96), // Granular change
              const FlSpot(0.06, 2.94), // Granular change
              const FlSpot(0.08, 2.92), // Granular change
              const FlSpot(0.1, 2.9), // Original point
              const FlSpot(0.5, 2.75), // Granular change
              const FlSpot(1.0, 2.6), // Granular change
              const FlSpot(1.5, 2.4), // Granular change
              const FlSpot(2.0, 2.2), // Granular change
              const FlSpot(2.2, 2.1), // Granular change
              const FlSpot(2.4, 2.05), // Granular change
              const FlSpot(2.6, 2), // Original point
              const FlSpot(2.8, 2.3), // Granular change
              const FlSpot(3.0, 2.5), // Granular change
              const FlSpot(3.2, 2.7), // Granular change
              const FlSpot(3.4, 2.9), // Granular change
              const FlSpot(3.6, 3.2), // Granular change
              const FlSpot(3.8, 3.5), // Granular change
              const FlSpot(4.0, 3.8), // Granular change
              const FlSpot(4.2, 4.1), // Granular change
              const FlSpot(4.4, 4.4), // Granular change
              const FlSpot(4.6, 4.7), // Granular change
              const FlSpot(4.9, 5), // Original point
              const FlSpot(5.2, 4.9), // Granular change
              const FlSpot(5.5, 4.8), // Granular change
              const FlSpot(5.8, 4.7), // Granular change
              const FlSpot(6.0, 4.5), // Granular change
              const FlSpot(6.3, 4.0), // Granular change
              const FlSpot(6.5, 3.5), // Granular change
              const FlSpot(6.7, 3.2), // Granular change
              const FlSpot(6.8, 3.1), // Original point
              const FlSpot(7.0, 3.2), // Granular change
              const FlSpot(7.2, 3.3), // Granular change
              const FlSpot(7.4, 3.5), // Granular change
              const FlSpot(7.6, 3.7), // Granular change
              const FlSpot(7.8, 3.9), // Granular change
              const FlSpot(8.0, 4), // Original point
              const FlSpot(8.2, 3.9), // Granular change
              const FlSpot(8.4, 3.8), // Granular change
              const FlSpot(8.6, 3.7), // Granular change
              const FlSpot(8.8, 3.6), // Granular change
              const FlSpot(9.0, 3.5), // Granular change
              const FlSpot(9.2, 3.4), // Granular change
              const FlSpot(9.4, 3.2), // Granular change
              const FlSpot(9.5, 3), // Original point
              const FlSpot(9.7, 3.2), // Granular change
              const FlSpot(9.9, 3.4), // Granular change
              const FlSpot(10.1, 3.5), // Granular change
              const FlSpot(10.3, 3.6), // Granular change
              const FlSpot(10.5, 3.7), // Granular change
              const FlSpot(10.7, 3.8), // Granular change
              const FlSpot(10.9, 3.9), // Granular change
              const FlSpot(11.0, 4), // Final original point

              // const FlSpot(0, 3),
              // const FlSpot(0.1, 2.9),
              // const FlSpot(2.6, 2),
              // const FlSpot(4.9, 5),
              // const FlSpot(6.8, 3.1),
              // const FlSpot(8, 4),
              // const FlSpot(9.5, 3),
              // const FlSpot(11, 4),
            ],
            isCurved: true,
            color: AppColors.baseColor,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              spotsLine: BarAreaSpotsLine(
                  show: true,
                  flLineStyle: FlLine(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.baseColor.withOpacity(0.3),
                        AppColors.baseColor.withOpacity(0.1)
                      ], // Gradient colors
                      begin:
                          Alignment.topCenter, // Starting point of the gradient
                      end: Alignment
                          .bottomCenter, // Ending point of the gradient
                    ),
                    strokeWidth: 1,
                  )),
              show: true,
              color: AppColors.baseColor.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }
}
