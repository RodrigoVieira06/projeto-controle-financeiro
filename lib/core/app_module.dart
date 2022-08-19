import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/screens/home/home_module.dart';
import 'package:projeto_controle_financeiro/screens/login/login_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: LoginModule()),
        ModuleRoute('/home', module: HomeModule()),
      ];
}
