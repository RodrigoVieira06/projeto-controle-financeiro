import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/auth/controller/auth_controller.dart';

class ConfirmacaoExclusaoWidget extends StatelessWidget {
  const ConfirmacaoExclusaoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = AuthController();

    return AlertDialog(
      title: const Text(
        'Apagar conta',
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          fontFamily: 'Lato',
        ),
      ),
      content: SizedBox(
        width: 300,
        height: 200,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Tem certeza que deseja excluir sua conta de usuário?',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 18,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Este processo é irreversível e você retornará para a tela de login!',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      authController.delete(context);
                      Modular.to.navigate('/');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[400],
                      minimumSize: const Size(100, 40),
                    ),
                    child: const Text(
                      'Apagar conta',
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
    );
  }
}
