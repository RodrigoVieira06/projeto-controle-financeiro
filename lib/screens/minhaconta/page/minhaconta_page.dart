import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/screens/minhaconta/components/components.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';

class MinhacontaPage extends StatelessWidget {
  const MinhacontaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const MinhacontaWidget minhacontaWidget = MinhacontaWidget();

    return Scaffold(
      backgroundColor: projectTheme.backgroundColor,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text(
          'MINHA CONTA',
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: projectTheme.primaryColor,
        titleTextStyle: const TextStyle(
          fontFamily: 'Lato',
          fontSize: 21,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: minhacontaWidget,
    );
  }
}
