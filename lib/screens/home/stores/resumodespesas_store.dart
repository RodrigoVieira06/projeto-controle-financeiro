import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class ResumodespesasStore extends NotifierStore<Exception, Resumodespesas> {
  final MovimentacoesService movimentacoesService = MovimentacoesService();
  final DateTime dataAtual = DateTime.now();

  ResumodespesasStore()
      : super(Resumodespesas(
          totalCredito: -1,
          totalDebito: -1,
          totalDinheiro: -1,
          totalPix: -1,
        )) {
    getDados();
  }

  getDados() async {
    try {
      setLoading(true);

      final List<Despesa> despesas = await movimentacoesService.getDespesas();

      final Resumodespesas resumodespesas = Resumodespesas(
        totalDebito: _getTotalDebito(despesas),
        totalCredito: _getTotalCredito(despesas),
        totalDinheiro: _getTotalDinheiro(despesas),
        totalPix: _getTotalPix(despesas),
      );

      update(resumodespesas);
      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }

  num _getTotalDebito(List<Despesa> despesas) {
    num valorTotal = 0;

    for (var despesa in despesas) {
      if (despesa.formaPagamento == "Débito") {
        valorTotal += despesa.valor;
      }
    }
    return valorTotal;
  }

  num _getTotalCredito(List<Despesa> despesas) {
    num valorTotal = 0;
    for (var despesa in despesas) {
      if (despesa.formaPagamento == "Crédito") {
        valorTotal += despesa.valor;
      }
    }
    return valorTotal;
  }

  num _getTotalDinheiro(List<Despesa> despesas) {
    num valorTotal = 0;
    for (var despesa in despesas) {
      if (despesa.formaPagamento == "Dinheiro") {
        valorTotal += despesa.valor;
      }
    }
    return valorTotal;
  }

  num _getTotalPix(List<Despesa> despesas) {
    num valorTotal = 0;
    for (var despesa in despesas) {
      if (despesa.formaPagamento == "Pix") {
        valorTotal += despesa.valor;
      }
    }
    return valorTotal;
  }
}
