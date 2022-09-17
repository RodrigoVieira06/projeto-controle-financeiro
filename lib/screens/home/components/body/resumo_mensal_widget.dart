import 'package:flutter/cupertino.dart';
import 'package:projeto_controle_financeiro/screens/home/components/cards/cards.dart';
import 'package:projeto_controle_financeiro/screens/home/components/date_select/date_select_widget.dart';

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
            PercentualGastosCard(),
          ],
        ),
      ],
    );
  }
}
