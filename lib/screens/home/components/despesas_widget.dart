import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DespesasWidget extends StatelessWidget {
  const DespesasWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: const Color.fromARGB(255, 255, 139, 72),
                  ),
                  height: 260,
                ),
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        color: Colors.white,
                      ),
                      height: 255,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 55,
                            color: const Color.fromARGB(
                              255,
                              255,
                              139,
                              72,
                            ),
                            child: const ListTile(
                              textColor: Colors.white,
                              title: Text(
                                'Despesas',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16,
                              left: 16,
                              right: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: AspectRatio(
                                    aspectRatio: 1.5,
                                    child: PieChart(
                                      PieChartData(
                                        sections: [
                                          PieChartSectionData(
                                            color: const Color.fromARGB(
                                                255, 29, 68, 167),
                                            value: 80,
                                            title: '80%',
                                            titleStyle: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffffffff)),
                                          ),
                                          PieChartSectionData(
                                            color: const Color.fromARGB(
                                                255, 39, 150, 165),
                                            value: 20,
                                            title: '20%',
                                            titleStyle: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffffffff)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Entretenimento'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Saúde'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
