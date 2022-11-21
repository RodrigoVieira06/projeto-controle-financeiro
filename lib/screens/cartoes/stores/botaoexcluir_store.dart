import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class BotaoexcluirStore extends NotifierStore<Exception, num> {
  final MovimentacoesService movimentacoesService = MovimentacoesService();
  final CartoesService cartoesService = CartoesService();

  BotaoexcluirStore(String cartaoId, String entityName) : super(0) {
    verifyDelete(cartaoId, entityName);
  }

  verifyDelete(String cartaoId, String entityName) async {
    try {
      setLoading(true);

      final String tipo;
      String? cartaoName;
      bool bloqueio = false;

      if (entityName == 'cartoesCredito') {
        tipo = 'Crédito';
        List<CartaoCredito> cartoes =
            await cartoesService.getCartoes(entityName);
        for (var cartao in cartoes) {
          if (cartao.uid == cartaoId) {
            cartaoName = cartao.titulo;
            break;
          }
        }
      } else if (entityName == 'cartoesDebito') {
        tipo = 'Débito';
        List<CartaoDebito> cartoes =
            await cartoesService.getCartoes(entityName);
        for (var cartao in cartoes) {
          if (cartao.uid == cartaoId) {
            cartaoName = cartao.titulo;
            break;
          }
        }
      } else {
        throw Exception('Entidade não encontrada.');
      }
      if (cartaoName == null) {
        throw Exception('Cartão não encontrado.');
      }

      List<Despesa> despesas = await movimentacoesService.getDespesas();

      for (var despesa in despesas) {
        if (despesa.formaPagamento == tipo) {
          if (despesa.cartao == cartaoName) {
            bloqueio = true;
            break;
          }
        }
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
