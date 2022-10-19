import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/screens/movimentacoes/page/movimentacoes_page_widget.dart';

class MovimentacoesModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) => const MovimentacoesPageWidget()),
      ];
}
