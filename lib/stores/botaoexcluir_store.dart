import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class BotaoexcluirStore extends NotifierStore<Exception, num> {
  final MovimentacoesService movimentacoesService = MovimentacoesService();
  final CartoesService _cartoesService = CartoesService();
  final CategoriasService _categoriasService = CategoriasService();

  BotaoexcluirStore(String entityId, String entityName) : super(0) {
    verifyDelete(entityId, entityName);
  }

  verifyDelete(String entityId, String entityName) async {
    try {
      setLoading(true);

      final String tipo;
      String? entityTitulo;
      bool bloqueio = false;

      if (entityName == 'cartoesCredito' ||
          entityName == 'cartoesDebito' ||
          entityName == 'categoriasDespesas') {
        List<Despesa> despesas = await movimentacoesService.getDespesas();
        if (entityName == 'cartoesCredito') {
          tipo = 'Crédito';
          List<CartaoCredito> cartoes =
              await _cartoesService.getCartoes(entityName);
          for (var cartao in cartoes) {
            if (cartao.id == entityId) {
              entityTitulo = cartao.titulo;
              break;
            }
          }
          for (var despesa in despesas) {
            if (despesa.formaPagamento == tipo) {
              if (despesa.cartao == entityTitulo) {
                bloqueio = true;
                break;
              }
            }
          }
        } else if (entityName == 'cartoesDebito') {
          tipo = 'Débito';
          List<CartaoDebito> cartoes =
              await _cartoesService.getCartoes(entityName);
          for (var cartao in cartoes) {
            if (cartao.id == entityId) {
              entityTitulo = cartao.titulo;
              break;
            }
          }
          for (var despesa in despesas) {
            if (despesa.formaPagamento == tipo) {
              if (despesa.cartao == entityTitulo) {
                bloqueio = true;
                break;
              }
            }
          }
        } else {
          List<Categoria> categorias =
              await _categoriasService.getCategorias(entityName);
          for (var categoria in categorias) {
            if (categoria.id == entityId) {
              entityTitulo = categoria.titulo;
              break;
            }
          }
          for (var despesa in despesas) {
            if (despesa.categoria == entityTitulo) {
              bloqueio = true;
              break;
            }
          }
        }
      } else if (entityName == 'categoriasFaturamentos') {
        List<Faturamento> faturamentos =
            await movimentacoesService.getFaturamentos();
        List<Categoria> categorias =
            await _categoriasService.getCategorias(entityName);
        for (var categoria in categorias) {
          if (categoria.id == entityId) {
            entityTitulo = categoria.titulo;
            break;
          }
        }
        for (var faturamento in faturamentos) {
          if (faturamento.categoria == entityTitulo) {
            bloqueio = true;
            break;
          }
        }
      } else {
        throw 'Entidade não encontrada.';
      }

      // 1 = botão excluir não pode aparecer, pois existem movimentações vinculadas;
      // 2 = botão excluir pode aparecer.
      bloqueio ? update(1) : update(2);

      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }
}
