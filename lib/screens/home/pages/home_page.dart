import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/components/drawer_widget.dart';
import 'package:projeto_controle_financeiro/screens/home/components/nav_bar_widget.dart';
import 'package:projeto_controle_financeiro/screens/home/components/body/inicio_widget.dart';
import 'package:projeto_controle_financeiro/screens/home/pages/relatorios_page.dart';
import 'package:projeto_controle_financeiro/screens/home/pages/resumo_mensal_page.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const InicioWidget(),
    const ResumoMensalPage(),
    const RelatoriosPage(),
  ];

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
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Resumo mensal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Relatórios',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: projectTheme.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
