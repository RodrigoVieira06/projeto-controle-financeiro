import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/screens/home/components/cards/cards.dart';

class InicioWidget extends StatelessWidget {
  const InicioWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        const Padding(
          padding:
              EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0, bottom: 8.0),
          child: VisaogeralCard(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
          child: GraficogeralCard(),
        ),
        // GraficoGeralCard(),
      ]),
    );
  }
}
