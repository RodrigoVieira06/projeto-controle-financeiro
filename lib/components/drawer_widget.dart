import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/core/auth/services/auth_service.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context);
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              color: projectTheme.primaryColor,
              height: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 60.0, bottom: 8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      minRadius: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      authService.usuario!.displayName!,
                      // ReadContext(context)
                      //     .read<AuthService>()
                      //     .getUser()!
                      //     .displayName!,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      authService.usuario!.email!,
                      // ReadContext(context)
                      //     .read<AuthService>()
                      //     .getUser()!
                      //     .email!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ElevatedButton(
                      onPressed: () => authService.logout(),
                      // ReadContext(context).read<AuthService>().logout(),
                      child: const Text('Logout'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'Painel Inicial',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () => Modular.to.navigate('/home/'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.attach_money_sharp),
              title: const Text(
                'Faturamentos',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.money_off),
              title: const Text(
                'Despesas',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.account_balance_wallet_rounded),
              title: const Text(
                'Carteiras',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
