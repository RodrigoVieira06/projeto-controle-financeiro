import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/screens/cartoes/module/cartoes_module.dart';
import 'package:projeto_controle_financeiro/screens/fluxodecaixa/module/fluxodecaixa_module.dart';
import 'package:projeto_controle_financeiro/screens/graficos/module/graficos_module.dart';
import 'package:projeto_controle_financeiro/screens/home/module/home_module.dart';
import 'package:projeto_controle_financeiro/screens/login/module/login_module.dart';
import 'package:projeto_controle_financeiro/screens/tiposdepesasfaturamentos/module/tiposdespesasfaturamentos_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          '/',
          module: LoginModule(),
        ),
        ModuleRoute(
          '/home',
          module: HomeModule(),
        ),
        ModuleRoute(
          '/fluxodecaixa',
          module: FluxodecaixaModule(),
        ),
        ModuleRoute(
          '/tiposdespesasfaturamentos',
          module: TiposdespesasfaturamentosModule(),
        ),
        ModuleRoute(
          '/cartoes',
          module: CartoesModule(),
        ),
        ModuleRoute(
          '/graficos',
          module: GraficosModule(),
        ),
      ];
}
