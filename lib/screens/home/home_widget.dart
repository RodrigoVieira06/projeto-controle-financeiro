import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/screens/home/components/despesas_widget.dart';
import 'package:projeto_controle_financeiro/screens/home/components/visao_geral_widget.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: const [
            VisaoGeralWidget(),
            DespesasWidget(),
          ],
        ),
      ],
    );
  }
}
