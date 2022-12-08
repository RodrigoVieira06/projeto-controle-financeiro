import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/screens/minhaconta/components/components.dart';
import 'package:projeto_controle_financeiro/services/auth_service.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';

class MinhacontaWidget extends StatelessWidget {
  const MinhacontaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = AuthService().getUser();
    const ConfirmacaoExclusaoWidget confirmacaoExclusaoWidget =
        ConfirmacaoExclusaoWidget();
    const AlterarSenhaWidget alterarSenhaWidget = AlterarSenhaWidget();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    left: 28.0,
                    bottom: 8.0,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Icon(
                          Icons.person,
                          size: 28,
                          color: projectTheme.primaryColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          'Dados de usuário',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato',
                            color: projectTheme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 4, 45, 78),
                    minRadius: 50,
                    maxRadius: 50,
                    // backgroundImage: setImage(),
                    child: Text(
                      user!.displayName![0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Lato',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 40.0),
                        child: Text(
                          'Nome:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Lato',
                            color: projectTheme.primaryColor,
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          initialValue: user.displayName,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabled: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 40.0),
                        child: Text(
                          'Email:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Lato',
                            color: projectTheme.primaryColor,
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          initialValue: user.email,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabled: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  alterarSenhaWidget,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black12,
                            minimumSize: const Size(140, 40),
                            maximumSize: const Size(140, 40),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(right: 2.0),
                                child: Icon(
                                  Icons.key,
                                  size: 18,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 2.0),
                                child: Text(
                                  'Alterar senha',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  confirmacaoExclusaoWidget,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red[400],
                            minimumSize: const Size(140, 40),
                            maximumSize: const Size(140, 40),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(right: 2.0),
                                child: Icon(
                                  Icons.delete_outline,
                                  size: 18,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 2.0),
                                child: Text(
                                  'Apagar conta',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
