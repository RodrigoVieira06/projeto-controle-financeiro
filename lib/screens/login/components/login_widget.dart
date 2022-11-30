import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/auth/controller/auth_controller.dart';
import 'package:projeto_controle_financeiro/screens/login/controllers/controllers.dart';
import 'package:projeto_controle_financeiro/utils/theme.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController auth = AuthController();
    final LoginWidgetController loginWidgetController = LoginWidgetController();

    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: loginWidgetController.formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 320,
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Image.asset(
                          'assets/images/logo_app.png',
                          height: 160,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: loginWidgetController.email,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe o seu email corretamente.';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: loginWidgetController.senha,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Senha',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe a sua senha.';
                            } else if (value.length < 6) {
                              return 'Senha inválida.';
                            }
                            return null;
                          },
                        ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (loginWidgetController.formKey.currentState!
                                    .validate()) {
                                  auth.login(
                                    context,
                                    loginWidgetController.email.text,
                                    loginWidgetController.senha.text,
                                  );
                                  Modular.to.navigate('/');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: projectTheme.primaryColor,
                                fixedSize: const Size(100, 10),
                              ),
                              child: const Text(
                                'Acessar',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Lato',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () => Modular.to.navigate('/cadastro'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey,
                                fixedSize: const Size(100, 10),
                              ),
                              child: const Text(
                                'Cadastrar',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Lato',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
