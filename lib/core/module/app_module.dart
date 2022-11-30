import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/screens/cartoes/module/cartoes_module.dart';
import 'package:projeto_controle_financeiro/screens/minhaconta/module/minhaconta_module.dart';
import 'package:projeto_controle_financeiro/screens/movimentacoes/module/movimentacoes_module.dart';
import 'package:projeto_controle_financeiro/screens/graficos/module/graficos_module.dart';
import 'package:projeto_controle_financeiro/screens/home/module/home_module.dart';
import 'package:projeto_controle_financeiro/screens/login/module/login_module.dart';
import 'package:projeto_controle_financeiro/screens/categorias/module/categorias_module.dart';

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
          '/movimentacoes',
          module: MovimentacoesModule(),
        ),
        ModuleRoute(
          '/categorias',
          module: CategoriasModule(),
        ),
        ModuleRoute(
          '/cartoes',
          module: CartoesModule(),
        ),
        ModuleRoute(
          '/graficos',
          module: GraficosModule(),
        ),
        ModuleRoute(
          '/minhaconta',
          module: MinhacontaModule(),
        ),
      ];
}
