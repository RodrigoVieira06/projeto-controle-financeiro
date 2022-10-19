import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/auth/auth_check.dart';
import 'package:projeto_controle_financeiro/auth/controller/auth_controller.dart';
import 'package:projeto_controle_financeiro/screens/login/page/login_page.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => AuthController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const AuthCheck()),
        ChildRoute('/login', child: (context, args) => const LoginPage()),
      ];
}
