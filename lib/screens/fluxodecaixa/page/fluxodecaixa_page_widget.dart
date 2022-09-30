import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/screens/fluxodecaixa/components/forms/forms.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';

class FluxodecaixaPageWidget extends StatefulWidget {
  const FluxodecaixaPageWidget({Key? key}) : super(key: key);

  @override
  State<FluxodecaixaPageWidget> createState() => _FluxodecaixaPageWidgetState();
}

class _FluxodecaixaPageWidgetState extends State<FluxodecaixaPageWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const DateSelectWidget(),
    const DateSelectWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: projectTheme.backgroundColor,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text(
          'FLUXO DE CAIXA',
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: projectTheme.primaryColor,
        titleTextStyle: const TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      floatingActionButton: AddButtonWidget(
        icon1: const Icon(Icons.attach_money),
        iconcolor1: const Color.fromARGB(255, 36, 137, 232),
        formdialog1: FaturamentosFormWidget(),
        icon2: const Icon(Icons.money_off),
        iconcolor2: const Color.fromARGB(255, 255, 67, 67),
        formdialog2: DespesasFormWidget(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.money_off),
            backgroundColor: Colors.red[400],
            label: 'Despesas',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.attach_money_rounded),
            backgroundColor: Colors.blue[400],
            label: 'Faturamentos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: projectTheme.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
