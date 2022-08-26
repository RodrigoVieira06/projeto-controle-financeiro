import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/components/drawer_widget.dart';
import 'package:projeto_controle_financeiro/components/nav_bar_widget.dart';
import 'package:projeto_controle_financeiro/screens/home/home_widget.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text('Controle Financeiro'),
        backgroundColor: projectTheme.primaryColor,
        titleTextStyle: const TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: const HomeWidget(),
      bottomNavigationBar: const NavBarWidget(),
    );
  }
}
