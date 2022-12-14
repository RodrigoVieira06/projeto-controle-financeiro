import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/screens/cartoes/components/components.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';

class CartoesPageWidget extends StatefulWidget {
  const CartoesPageWidget({Key? key}) : super(key: key);

  @override
  State<CartoesPageWidget> createState() => _CartoesPageWidgetState();
}

class _CartoesPageWidgetState extends State<CartoesPageWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const CartoesCreditoWidget(),
    const CartoesDebitoWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: projectTheme.backgroundColor,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text(
          'CARTÕES',
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
        text1: 'Cartão de crédito',
        icon1: Icon(Icons.credit_card),
        iconcolor1: Color.fromARGB(255, 102, 187, 106),
        formdialog1: CartoesFormWidget(
          entityName: 'cartoesCredito',
        ),
        text2: 'Cartão de débito',
        icon2: Icon(Icons.credit_card),
        iconcolor2: Color.fromARGB(255, 36, 137, 232),
        formdialog2: CartoesFormWidget(
          entityName: 'cartoesDebito',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.credit_card),
            backgroundColor: Colors.green[400],
            label: 'Cartões de crédito',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.credit_card),
            backgroundColor: Colors.blue[400],
            label: 'Cartões de débito',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: projectTheme.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
