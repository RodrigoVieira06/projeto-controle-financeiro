import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class PercentualGastosStore extends NotifierStore<Exception, num> {
  final MovimentacoesService movimentacoesService = MovimentacoesService();

  PercentualGastosStore(String entityName, String tipo) : super(-1) {
    getPercentualGastos(entityName, tipo);
  }

  getPercentualGastos(String entityName, String tipo) async {
    try {
      setLoading(true);
      num valorTotal = 0;
      num valorTotalEntity = 0;
      final num percentual;

      if (tipo == 'Crédito' || tipo == 'Débito' || tipo == 'Despesa') {
        List<Despesa> despesas = await movimentacoesService.getDespesas();
        for (var despesa in despesas) {
          if (tipo == 'Crédito' || tipo == 'Débito') {
            if (despesa.formaPagamento == tipo) {
              valorTotal += despesa.valor;
              if (despesa.cartao == entityName) {
                valorTotalEntity += despesa.valor;
              }
            }
          } else {
            valorTotal += despesa.valor;
            if (despesa.categoria == entityName) {
              valorTotalEntity += despesa.valor;
            }
          }
        }
      } else if (tipo == 'Faturamento') {
        List<Faturamento> faturamentos =
            await movimentacoesService.getFaturamentos();
        for (var faturamento in faturamentos) {
          valorTotal += faturamento.valor;
          if (faturamento.categoria == entityName) {
            valorTotalEntity += faturamento.valor;
          }
        }
      } else {
        throw Exception('Não foi possível encontrar o tipo da entidade');
      }

      percentual = (valorTotalEntity * 100) / valorTotal;

      update(percentual);

      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }
}
