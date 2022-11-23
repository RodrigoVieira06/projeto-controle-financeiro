import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class MediamensalStore extends NotifierStore<Exception, num> {
  final MovimentacoesService movimentacoesService = MovimentacoesService();

  MediamensalStore(String entityName, String tipo) : super(-1) {
    getMediaMensal(entityName, tipo);
  }

  getMediaMensal(String entityName, String tipo) async {
    try {
      setLoading(true);
      num valorTotal = 0;
      num quantidade = 0;

      if (tipo == 'Crédito' || tipo == 'Débito' || tipo == 'Despesa') {
        List<Despesa> despesas = await movimentacoesService.getDespesas();
        for (var despesa in despesas) {
          if (tipo == 'Crédito' || tipo == 'Débito') {
            if (despesa.formaPagamento == tipo) {
              if (despesa.cartao == entityName) {
                valorTotal += despesa.valor;
                quantidade++;
              }
            }
          } else {
            if (despesa.categoria == entityName) {
              valorTotal += despesa.valor;
              quantidade++;
            }
          }
        }
      } else if (tipo == 'Faturamento') {
        List<Faturamento> faturamentos =
            await movimentacoesService.getFaturamentos();
        for (var faturamento in faturamentos) {
          if (faturamento.categoria == entityName) {
            valorTotal += faturamento.valor;
            quantidade++;
          }
        }
      } else {
        throw Exception('Não foi possível encontrar o tipo da entidade');
      }

      quantidade == 0 ? update(0) : update(valorTotal / quantidade);

      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }
}
