import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/screens/home/components/cards/cards.dart';
import 'package:projeto_controle_financeiro/screens/home/stores/stores.dart';

class ResumoMensalWidget extends StatelessWidget {
  const ResumoMensalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // inicio - botões de seleção de filtro de mês e ano
    final DateselectButtonsWidget dateselectButtonsWidget =
        DateselectButtonsWidget();
    // fim - botões de seleção de filtro de mês e ano

    // inicio - stores contendo os dados a serem exibidos nos cards
    final ResumomensalStore resumomensalStore = ResumomensalStore();
    final ResumodespesasStore resumodespesasStore = ResumodespesasStore();
    // fim - stores contendo os dados a serem exibidos nos cards

    // inicio - Widgets dos cards usados na tela
    const ResumogeralCard resumomensalCard = ResumogeralCard();
    const ResumodespesasCard resumodespesasCard = ResumodespesasCard();
    // fim - Widgets dos cards usados na tela

    return SingleChildScrollView(
      child: Column(
        children: [
          dateselectButtonsWidget.buildWidget(
            context,
            [
              resumomensalStore.getDados,
              resumodespesasStore.getDados,
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: resumomensalCard.buildWidget(context, resumomensalStore),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
            child: resumodespesasCard.buildWidget(context, resumodespesasStore),
          ),
        ],
      ),
    );
  }
}
