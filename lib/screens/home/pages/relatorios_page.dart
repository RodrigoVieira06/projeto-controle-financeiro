import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/screens/home/components/despesas_widget.dart';

class RelatoriosPage extends StatelessWidget {
  const RelatoriosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: const [
            DespesasWidget(),
          ],
        ),
      ],
    );
  }
}
