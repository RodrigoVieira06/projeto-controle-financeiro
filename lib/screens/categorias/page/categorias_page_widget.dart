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
    const CategoriasDespesasWidget(entityName: 'categoriasDespesas'),
    const CategoriasFaturamentosWidget(entityName: 'categoriasFaturamentos'),
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
      floatingActionButton: const AddButtonWidget(
        text1: 'Categoria de despesa',
        icon1: Icon(Icons.money_off),
        iconcolor1: Color.fromARGB(255, 255, 67, 67),
        formdialog1: CategoriasFormWidget(
          entityName: 'categoriasDespesas',
        ),
        text2: 'Categoria de faturamento',
        icon2: Icon(Icons.attach_money),
        iconcolor2: Color.fromARGB(255, 36, 137, 232),
        formdialog2: CategoriasFormWidget(
          entityName: 'categoriasFaturamentos',
        ),
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
