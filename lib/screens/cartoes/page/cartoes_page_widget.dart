import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
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
          'CARTÕES',
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
        icon1: const Icon(Icons.credit_card),
        iconcolor1: const Color.fromARGB(255, 49, 205, 244),
        formdialog1: Container(),
        icon2: const Icon(Icons.credit_card),
        iconcolor2: const Color.fromARGB(255, 177, 67, 255),
        formdialog2: Container(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            backgroundColor: Color.fromARGB(255, 0, 27, 67),
            label: 'Crédito',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            backgroundColor: Color.fromARGB(255, 0, 27, 67),
            label: 'Débito',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: projectTheme.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
