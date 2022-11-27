import 'package:flutter/cupertino.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/screens/home/components/cards/cards.dart';

class ResumoMensalWidget extends StatelessWidget {
  ResumoMensalWidget({Key? key}) : super(key: key);
  final DateselectButtonsWidget dateselectButtonsWidget =
      DateselectButtonsWidget();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            // dateselectButtonsWidget.buildWidget(context),
            const ResumomensalCard(),
            const ResumodespesasCard(),
          ],
        ),
      ],
    );
  }
}
