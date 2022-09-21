import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';

class TiposdespesasfaturamentosPageWidget extends StatefulWidget {
  const TiposdespesasfaturamentosPageWidget({Key? key}) : super(key: key);

  @override
  State<TiposdespesasfaturamentosPageWidget> createState() =>
      _TiposdespesasfaturamentosPageWidgetState();
}

class _TiposdespesasfaturamentosPageWidgetState
    extends State<TiposdespesasfaturamentosPageWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.blue,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: projectTheme.backgroundColor,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text(
          'TIPOS DE DESPESAS E FATURAMENTOS',
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: projectTheme.primaryColor,
        titleTextStyle: const TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 0, 27, 67),
        child: const Icon(Icons.add),
        onPressed: () => {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.money_off),
            backgroundColor: Colors.red[400],
            label: 'Tipos de despesas',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.attach_money_rounded),
            backgroundColor: Colors.blue[400],
            label: 'Tipos de faturamentos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: projectTheme.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
