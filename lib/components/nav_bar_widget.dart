import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      // currentIndex: 0,
      selectedItemColor: projectTheme.primaryColor,
      // onTap: _onItemTapped,
    );
  }
}
