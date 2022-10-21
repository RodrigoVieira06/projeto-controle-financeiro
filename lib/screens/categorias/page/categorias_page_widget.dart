import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/screens/categorias/components/components.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';

class CategoriasPageWidget extends StatefulWidget {
  const CategoriasPageWidget({Key? key}) : super(key: key);

  @override
  State<CategoriasPageWidget> createState() => _CategoriasPageWidgetState();
}

class _CategoriasPageWidgetState extends State<CategoriasPageWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const CategoriasDespesasWidget(),
    const CategoriasFaturamentosWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: projectTheme.backgroundColor,
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: const Text(
          'CATEGORIAS',
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
      floatingActionButton: AddButtonWidget(
        text1: 'Categorias de despesas',
        icon1: const Icon(Icons.money_off),
        iconcolor1: const Color.fromARGB(255, 255, 67, 67),
        formdialog1: CategoriasDespesasFormWidget(),
        text2: 'Categorias de daturamentos',
        icon2: const Icon(Icons.attach_money),
        iconcolor2: const Color.fromARGB(255, 36, 137, 232),
        formdialog2: CategoriasFaturamentosFormWidget(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.money_off),
            backgroundColor: Colors.red[400],
            label: 'Categorias de despesas',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.attach_money_rounded),
            backgroundColor: Colors.blue[400],
            label: 'Categorias de faturamentos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: projectTheme.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
