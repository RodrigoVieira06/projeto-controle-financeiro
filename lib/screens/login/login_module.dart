import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/core/auth/components/auth_check.dart';
import 'package:projeto_controle_financeiro/core/auth/services/auth_service.dart';
import 'package:projeto_controle_financeiro/screens/login/login_page.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => AuthService()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const AuthCheck()),
        ChildRoute('/login', child: (context, args) => const LoginPage()),
      ];
}
