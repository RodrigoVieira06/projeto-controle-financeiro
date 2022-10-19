import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/auth/controller/auth_controller.dart';
import 'package:projeto_controle_financeiro/services/services.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key}) : super(key: key);

  final User? user = AuthService().getUser();
  final AuthController auth = AuthController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: projectTheme.primaryColor,
            height: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 60.0, bottom: 8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        minRadius: 50,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        user!.displayName ?? "",
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Lato',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        user!.email ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Lato',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 16),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          minimumSize: const Size(80, 30),
                        ),
                        child: Text(
                          'Minha conta',
                          style: TextStyle(
                            color: projectTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          auth.logout();
                          // Modular.to.navigate('/');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 218, 93, 84),
                          minimumSize: const Size(80, 30),
                        ),
                        child: const Text(
                          'Sair',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.home),
              title: Text(
                'Painel inicial',
                style: TextStyle(
                  fontSize: 16,
                  color: projectTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
              onTap: () => Modular.to.navigate('/home/'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.swap_vertical_circle_sharp),
              title: Text(
                'Fluxo de caixa',
                style: TextStyle(
                  fontSize: 16,
                  color: projectTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
              onTap: () => Modular.to.navigate('/fluxodecaixa/'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.monetization_on),
              title: Text(
                'Categorias',
                style: TextStyle(
                  fontSize: 16,
                  color: projectTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
              onTap: () => Modular.to.navigate('/tiposdespesasfaturamentos/'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.credit_card),
              title: Text(
                'Cartões',
                style: TextStyle(
                  fontSize: 16,
                  color: projectTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
              onTap: () => Modular.to.navigate('/cartoes/'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.bar_chart_rounded),
              title: Text(
                'Gráficos',
                style: TextStyle(
                  fontSize: 16,
                  color: projectTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              ),
              onTap: () => Modular.to.navigate('/graficos/'),
            ),
          ),
        ],
      ),
    );
  }
}
