import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class MediamensalStore extends NotifierStore<Exception, num> {
  final MovimentacoesService movimentacoesService = MovimentacoesService();

  MediamensalStore(String cartaoName, String tipo) : super(-1) {
    getMediaMensal(cartaoName, tipo);
  }

  getMediaMensal(String cartaoName, String tipo) async {
    try {
      setLoading(true);
      num valorTotal = 0;
      num quantidade = 0;

      List<Despesa> despesas = await movimentacoesService.getDespesas();

      for (var despesa in despesas) {
        if (despesa.formaPagamento == tipo) {
          if (despesa.cartao == cartaoName) {
            valorTotal += despesa.valor;
            quantidade++;
          }
        }
      }

      quantidade == 0 ? update(0) : update(valorTotal / quantidade);

      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }
}
