import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/screens/movimentacoes/components/components.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';

class MovimentacoesPageWidget extends StatefulWidget {
  const MovimentacoesPageWidget({Key? key}) : super(key: key);

  @override
  State<MovimentacoesPageWidget> createState() =>
      _MovimentacoesPageWidgetState();
}

class _MovimentacoesPageWidgetState extends State<MovimentacoesPageWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const DespesasWidget(),
    const FaturamentosWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: projectTheme.backgroundColor,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text(
          'MOVIMENTAÇÕES',
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
      body: _widgetOptions.elementAt(_selectedIndex),
      floatingActionButton: const AddButtonWidget(
        text1: 'Despesas',
        icon1: Icon(Icons.money_off),
        iconcolor1: Color.fromARGB(255, 255, 67, 67),
        formdialog1: DespesasFormWidget(),
        text2: 'Faturamentos',
        icon2: Icon(Icons.attach_money),
        iconcolor2: Color.fromARGB(255, 36, 137, 232),
        formdialog2: FaturamentosFormWidget(),
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
