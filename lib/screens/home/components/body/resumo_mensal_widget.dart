import 'package:flutter/cupertino.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/screens/home/components/cards/cards.dart';

class ResumoMensalWidget extends StatelessWidget {
  const ResumoMensalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: const [
            DateSelectWidget(),
            ResumoDespesasCard(),
            // Padding(
            //   padding: EdgeInsets.only(bottom: 32.0),
            //   child: PercentualGastosCard(),
            // ),
          ],
        ),
      ],
    );
  }
}
