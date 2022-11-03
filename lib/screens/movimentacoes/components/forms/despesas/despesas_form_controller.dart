import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_controle_financeiro/models/models.dart';

class DespesasFormController {
  // inicio - definição de controladores dos campos do formulário
  final formKey = GlobalKey<FormState>();
  TextEditingController titulo = TextEditingController();
  TextEditingController valor = TextEditingController();
  TextEditingController data = TextEditingController();
  TextEditingController observacoes = TextEditingController();
  // fim - definição de configurações dos campos do formulário

  // inicio - declaração dos valores dos campos do formulário
  String? formaPagamentoValue;
  String? categoriaValue;
  String? cartoesCreditoValue;
  String? cartoesDebitoValue;
  // fim - declaração dos valores dos campos do formulário

  // inicio - declaração de listas que serão utilizadas nos selects do formulário
  late final List<String> formasPagamento;
  late final List<String>? categoria;
  // fim - declaração de listas que serão utilizadas nos selects do formulário

  late final Despesa? despesa;

  DespesasFormController(Map<String, dynamic> dadosForm) {
    _getInitialData(dadosForm);
  }

  _getInitialData(Map<String, dynamic> dadosForm) {
    formasPagamento = getFormasPagamento();
    categoria = dadosForm['categoriasDespesas'];
    despesa = dadosForm['despesa'];

    if (despesa != null) {
      titulo = TextEditingController(text: despesa!.titulo);
      valor = TextEditingController(text: despesa!.valor.toString());
      data = TextEditingController(
          text: DateFormat('dd/MM/yyyy')
              .format(DateTime.fromMillisecondsSinceEpoch(
        despesa!.data.millisecondsSinceEpoch,
      )));
      categoriaValue = despesa!.categoria;
      formaPagamentoValue = despesa!.formaPagamento;
      observacoes = TextEditingController(text: despesa!.observacoes);
      if (despesa!.formaPagamento == 'Crédito') {
        cartoesCreditoValue = despesa!.cartao;
      } else if (despesa!.formaPagamento == 'Débito') {
        cartoesDebitoValue = despesa!.cartao;
      }
    }
  }

  List<String> getFormasPagamento() {
    return [
      'Dinheiro',
      'Pix',
      'Débito',
      'Crédito',
    ];
  }
}
