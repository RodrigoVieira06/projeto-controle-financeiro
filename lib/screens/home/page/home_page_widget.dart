import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/components/components.dart';
import 'package:projeto_controle_financeiro/screens/home/components/body/body.dart';
import 'package:projeto_controle_financeiro/screens/home/components/forms/forms.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late AnimationController _animationController;

  late Animation<double> _buttonAnimatedIcon;

  late Animation<double> _translateButton;

  bool _isExpanded = false;

  @override
  initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..addListener(() {
        setState(() {});
      });

    _buttonAnimatedIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _translateButton = Tween<double>(
      begin: 100,
      end: -20,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _toggle() {
    if (_isExpanded) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    _isExpanded = !_isExpanded;
  }

  final List<Widget> _widgetOptions = <Widget>[
    const InicioWidget(),
    const ResumoMensalWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: projectTheme.backgroundColor,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text(
          'PAINEL INICIAL',
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Transform(
              transform: Matrix4.translationValues(
                0.0,
                _translateButton.value * 3,
                0.0,
              ),
              child: FloatingActionButton(
                backgroundColor: Colors.blue[400],
                child: const Icon(Icons.attach_money),
                onPressed: () => {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FaturamentosFormWidget();
                    },
                  )
                },
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(
                0.0,
                _translateButton.value * 2,
                0.0,
              ),
              child: FloatingActionButton(
                backgroundColor: Colors.red[400],
                child: const Icon(Icons.money_off),
                onPressed: () => {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DespesasFormWidget();
                    },
                  )
                },
              ),
            ),
            FloatingActionButton(
              onPressed: _toggle,
              backgroundColor: const Color.fromARGB(255, 0, 27, 67),
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: _buttonAnimatedIcon,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Color.fromARGB(255, 0, 27, 67),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            backgroundColor: Color.fromARGB(255, 0, 27, 67),
            label: 'Resumo mensal',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: projectTheme.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
