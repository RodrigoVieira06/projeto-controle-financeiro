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
      drawer: DrawerWidget(),
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
      floatingActionButton: AddButtonWidget(
        text1: 'Cartão de crédito',
        icon1: const Icon(Icons.money_off),
        iconcolor1: const Color.fromARGB(255, 255, 67, 67),
        formdialog1: CartoesCreditoFormWidget(),
        text2: 'Cartão de débito',
        icon2: const Icon(Icons.attach_money),
        iconcolor2: const Color.fromARGB(255, 36, 137, 232),
        formdialog2: CartoesDebitoFormWidget(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.credit_card),
            backgroundColor: Colors.red[400],
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
