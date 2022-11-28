import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/utils/utils.dart';

class GraficogeralWidget {
  GraficogeralWidget();

  Widget leftTitleWidgets(double valor, TitleMeta titleMeta) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        'R\$ ${valor.toStringAsFixed(2)}',
        style: const TextStyle(
          fontFamily: 'Lato',
          fontSize: 10,
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double mes, TitleMeta titleMeta) {
    final Conversoes conversoes = Conversoes();

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        conversoes.convertResumedMonth(mes.toInt()),
        style: const TextStyle(
          fontFamily: 'Lato',
        ),
      ),
    );
  }

  Widget buildWidget(
      BuildContext context, Map<String, List<FlSpot>> graficogeral) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots: graficogeral['despesas'] ?? [],
              gradient: const LinearGradient(
                colors: [
                  Colors.orange,
                  Colors.red,
                ],
              ),
              isCurved: false,
              isStrokeCapRound: true,
              barWidth: 3,
              belowBarData: BarAreaData(
                show: false,
              ),
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 3,
                  color: Colors.red[400],
                ),
              ),
            ),
            LineChartBarData(
              spots: graficogeral['faturamentos'] ?? [],
              gradient: const LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.cyan,
                ],
              ),
              isCurved: false,
              isStrokeCapRound: true,
              barWidth: 3,
              belowBarData: BarAreaData(
                show: false,
              ),
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 3,
                  color: Colors.blue[400],
                ),
              ),
            ),
            LineChartBarData(
              spots: graficogeral['balanco'] ?? [],
              gradient: const LinearGradient(
                colors: [
                  Colors.green,
                  Colors.lightGreen,
                ],
              ),
              isCurved: false,
              isStrokeCapRound: true,
              barWidth: 3,
              belowBarData: BarAreaData(
                show: false,
              ),
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 3,
                  color: Colors.green[400],
                ),
              ),
            ),
            LineChartBarData(
              spots: graficogeral['saldo'] ?? [],
              gradient: const LinearGradient(
                colors: [
                  Colors.deepPurple,
                  Colors.purple,
                ],
              ),
              isCurved: false,
              isStrokeCapRound: true,
              barWidth: 3,
              belowBarData: BarAreaData(
                show: false,
              ),
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 3,
                  color: Colors.deepPurple[400],
                ),
              ),
            ),
          ],
          minX: 1,
          maxX: 12,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 68,
                getTitlesWidget: leftTitleWidgets,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: bottomTitleWidgets,
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            verticalInterval: 1,
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              left: BorderSide(color: Colors.transparent),
              top: BorderSide(color: Colors.transparent),
              bottom: BorderSide(color: Colors.transparent),
              right: BorderSide(color: Colors.transparent),
            ),
          ),
        ),
      ),
    );
  }
}
