import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/auth/controller/auth_controller.dart';

class AlterarSenhaWidget extends StatelessWidget {
  AlterarSenhaWidget({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  TextEditingController senha = TextEditingController();
  TextEditingController confirmarSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthController authController = AuthController();

    return AlertDialog(
      content: SizedBox(
        width: 300,
        height: 330,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 24.0, left: 8.0),
                child: Text(
                  'Alterar senha',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: senha,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nova senha',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe a nova senha.';
                    } else if (value.length < 6) {
                      return 'A senha deve conter mais de 5 caracteres.';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: confirmarSenha,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Repita sua senha',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Repita a sua senha.';
                    } else if (value != senha.text) {
                      return 'A senha não é a mesma.';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await authController.alterarSenha(
                            context,
                            senha.text,
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 12, 47, 75),
                        minimumSize: const Size(100, 40),
                      ),
                      child: const Text(
                        'Confirmar',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black26,
                        minimumSize: const Size(100, 40),
                      ),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
