import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/screens/minhaconta/page/minhaconta_page.dart';

class MinhacontaModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const MinhacontaPage()),
      ];
}
