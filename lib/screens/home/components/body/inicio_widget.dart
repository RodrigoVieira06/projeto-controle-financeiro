import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/screens/home/components/visao_geral_widget.dart';

class InicioWidget extends StatelessWidget {
  const InicioWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: const [
            VisaoGeralWidget(),
          ],
        ),
      ],
    );
  }
}
