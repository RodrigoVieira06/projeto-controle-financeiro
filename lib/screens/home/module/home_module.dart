import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/screens/home/controllers/controllers.dart';
import 'package:projeto_controle_financeiro/screens/home/page/home_page_widget.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<InicioController>((i) => InicioController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePageWidget()),
      ];
}
