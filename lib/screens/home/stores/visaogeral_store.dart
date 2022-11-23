import 'package:flutter_triple/flutter_triple.dart';
import 'package:projeto_controle_financeiro/models/despesa.dart';
import 'package:projeto_controle_financeiro/models/faturamento.dart';
import 'package:projeto_controle_financeiro/screens/home/models/models.dart';
import 'package:projeto_controle_financeiro/services/services.dart';

class VisaogeralStore extends NotifierStore<Exception, Visaogeral> {
  final MovimentacoesService movimentacoesService = MovimentacoesService();
  final DateTime dataAtual = DateTime.now();

  VisaogeralStore()
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

      List<Despesa> despesas = await movimentacoesService.getDespesas();
      List<Faturamento> faturamentos =
          await movimentacoesService.getFaturamentos();

      Visaogeral visaogeral = Visaogeral(
        saldoAtual: _getSaldoAtual(despesas, faturamentos),
        mediaDespesasMensais: _getMediaDespesasMensais(despesas),
        mediaBalancoMensal: _getMediaBalancoMensal(despesas, faturamentos),
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
      // confere
      if (despesa.data.microsecondsSinceEpoch <
          dataAtual.microsecondsSinceEpoch) {
        despesaTotal += despesa.valor;
      }
    }
    for (var faturamento in faturamentos) {
      if (faturamento.data.microsecondsSinceEpoch <
          dataAtual.microsecondsSinceEpoch) {
        faturamentoTotal += faturamento.valor;
      }
    }

    return faturamentoTotal - despesaTotal;
  }

  num _getMediaDespesasMensais(List<Despesa> despesas) {
    try {
      if (despesas.isEmpty) {
        return 0;
      }

      num mediaDespesasMensais = 0;
      num valorTotal = 0;
      List<DateTime> datas = [];

      // atribuindo valor total e datas das despesas
      for (var despesa in despesas) {
        valorTotal += despesa.valor;
        datas.add(DateTime.fromMicrosecondsSinceEpoch(
          despesa.data.microsecondsSinceEpoch,
        ));
      }

      mediaDespesasMensais = valorTotal / _getQuantidadeMeses(datas);

      return mediaDespesasMensais;
    } catch (error) {
      throw 'Erro ao calcular média';
    }
  }

  num _getMediaBalancoMensal(
      List<Despesa> despesas, List<Faturamento> faturamentos) {
    try {
      if (despesas.isEmpty && faturamentos.isEmpty) {
        return 0;
      }

      num mediaDespesasMensais = 0;
      num valorTotal = 0;
      List<DateTime> datas = [];

      // atribuindo valor total e datas das despesas
      for (var despesa in despesas) {
        valorTotal += despesa.valor * -1;
        datas.add(DateTime.fromMicrosecondsSinceEpoch(
          despesa.data.microsecondsSinceEpoch,
        ));
      }

      // atribuindo valor total e datas dos faturamentos
      for (var faturamento in faturamentos) {
        valorTotal += faturamento.valor;
        datas.add(DateTime.fromMicrosecondsSinceEpoch(
          faturamento.data.microsecondsSinceEpoch,
        ));
      }

      mediaDespesasMensais = valorTotal / _getQuantidadeMeses(datas);
      return mediaDespesasMensais;
    } catch (error) {
      throw 'Erro ao calcular média';
    }
  }

  num _getQuantidadeMeses(List<DateTime> datas) {
    num quantidadeMeses = 0;

    // ordenar datas obtidas
    datas.sort();

    // como a lista está ordenada por data, a cada mudança de mês ou ano,
    // a quantidade de meses será incrementada, afim de receber um total de meses
    for (var i = 0; i < datas.length; i++) {
      if (i + 1 == datas.length ||
          !(datas[i].month == datas[i + 1].month &&
              datas[i].year == datas[i + 1].year)) {
        quantidadeMeses++;
      }
    }

    return quantidadeMeses;
  }
}
