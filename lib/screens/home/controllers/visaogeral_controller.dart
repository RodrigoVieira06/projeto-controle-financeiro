import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/despesa.dart';
import 'package:projeto_controle_financeiro/models/faturamento.dart';
import 'package:projeto_controle_financeiro/screens/home/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class VisaogeralController extends NotifierStore<Exception, Visaogeral> {
  final DespesasService despesasService = DespesasService();
  final FaturamentosService faturamentosService = FaturamentosService();

  VisaogeralController()
      : super(Visaogeral(
          saldoAtual: -1,
          mediaDespesasMensais: -1,
          mediaBalancoMensal: -1,
        )) {
    getDados();
  }

  getDados() async {
    try {
      setLoading(true);

      List<Despesa> despesas = await despesasService.getDespesas();
      List<Faturamento> faturamentos =
          await faturamentosService.getFaturamentos();

      Visaogeral visaogeral = Visaogeral(
        saldoAtual: _getSaldoAtual(despesas, faturamentos),
        mediaDespesasMensais: 0,
        mediaBalancoMensal: 0,
      );

      update(visaogeral);
      setLoading(false);
    } catch (error) {
      setError(Exception(error));
    }
  }

  num _getSaldoAtual(List<Despesa> despesas, List<Faturamento> faturamentos) {
    num despesaTotal = 0;
    num faturamentoTotal = 0;

    for (var despesa in despesas) {
      despesaTotal += despesa.valor;
    }
    for (var faturamento in faturamentos) {
      faturamentoTotal += faturamento.valor;
    }

    return faturamentoTotal - despesaTotal;
  }
}
