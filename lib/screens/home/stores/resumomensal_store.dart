import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class ResumomensalStore extends NotifierStore<Exception, Resumomensal> {
  final MovimentacoesService movimentacoesService = MovimentacoesService();
  final DateTime dataAtual = DateTime.now();

  ResumomensalStore()
      : super(Resumomensal(
          saldoMes: -1,
          balancoMes: -1,
          totalDespesas: -1,
          totalFaturamentos: -1,
        )) {
    getDados();
  }

  getDados() async {
    try {
      setLoading(true);

      final List<Despesa> despesas = await movimentacoesService.getDespesas();
      final List<Faturamento> faturamentos =
          await movimentacoesService.getFaturamentos();

      final Resumomensal resumomensal = Resumomensal(
        saldoMes: _getSaldoMes(despesas, faturamentos),
        balancoMes: _getBalancoMes(despesas, faturamentos),
        totalDespesas: _getDespesasMes(despesas),
        totalFaturamentos: _getFaturamentosMes(faturamentos),
      );

      update(resumomensal);
      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }

  num _getSaldoMes(List<Despesa> despesas, List<Faturamento> faturamentos) {
    num valorTotal = 0;
    return valorTotal;
  }

  num _getBalancoMes(List<Despesa> despesas, List<Faturamento> faturamentos) {
    num valorTotal = 0;
    return valorTotal;
  }

  num _getDespesasMes(List<Despesa> despesas) {
    num valorTotal = 0;
    return valorTotal;
  }

  num _getFaturamentosMes(List<Faturamento> faturamentos) {
    num valorTotal = 0;
    return valorTotal;
  }
}
