import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/screens/tiposdepesasfaturamentos/page/tiposdespesasfaturamentos_page_widget.dart';

class TiposdespesasfaturamentosModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) =>
                const TiposdespesasfaturamentosPageWidget()),
      ];
}
