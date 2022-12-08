import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/screens/graficos/components/components.dart';

class GraficosGeraisWidget extends StatelessWidget {
  const GraficosGeraisWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const AccordionWidget accordionWidget = AccordionWidget();

    final PercentuaisCategoriasDespesasChart
        percentuaisCategoriasDespesasChart =
        PercentuaisCategoriasDespesasChart();

    final PercentuaisCategoriasFaturamentosChart
        percentuaisCategoriasFaturamentosChart =
        PercentuaisCategoriasFaturamentosChart();

    final PercentuaisCartoesCreditoChart percentuaisCartoesCreditoChart =
        PercentuaisCartoesCreditoChart();

    final PercentuaisCartoesDebitoChart percentuaisCartoesDebitoChart =
        PercentuaisCartoesDebitoChart();

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              left: 8.0,
              right: 8.0,
              bottom: 8.0,
            ),
            child: accordionWidget.buildWidget(
              context: context,
              title: 'CATEGORIAS DE DESEPESAS (%)',
              icon: Icons.money_off,
              iconColor: Colors.red[400],
              content: percentuaisCategoriasDespesasChart,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 8.0,
            ),
            child: accordionWidget.buildWidget(
              context: context,
              title: 'CATEGORIAS DE FATURAMENTOS (%)',
              icon: Icons.attach_money,
              iconColor: Colors.blue[400],
              content: percentuaisCategoriasFaturamentosChart,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 8.0,
            ),
            child: accordionWidget.buildWidget(
              context: context,
              title: 'CARTÕES DE CRÉDITO (%)',
              icon: Icons.credit_card,
              iconColor: Colors.green[400],
              content: percentuaisCartoesCreditoChart,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 16.0,
            ),
            child: accordionWidget.buildWidget(
              context: context,
              title: 'CARTÕES DE DÉBITO (%)',
              icon: Icons.credit_card,
              iconColor: Colors.blue[400],
              content: percentuaisCartoesDebitoChart,
            ),
          ),
          // GraficoGeralCard(),
        ],
      ),
    );
  }
}
