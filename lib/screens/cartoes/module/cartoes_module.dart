import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/screens/cartoes/page/cartoes_page_widget.dart';

class CartoesModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const CartoesPageWidget()),
      ];
}
