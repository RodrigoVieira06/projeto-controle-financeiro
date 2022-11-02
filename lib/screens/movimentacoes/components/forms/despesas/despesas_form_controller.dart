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

  // inicio - definição dos valores dos campos do formulário
  String? formaPagamentoValue;
  String? categoriasDespesasValue;
  String? cartoesCreditoValue;
  String? cartoesDebitoValue;
  // fim - definição dos valores dos campos do formulário

  late final List<String> formasPagamento;
  late final List<String>? categoriasDespesas;
  late final List<String>? cartoesCredito;
  late final List<String>? cartoesDebito;
  late final Despesa? despesa;

  DespesasFormController(Map<String, dynamic> dadosForm) {
    formasPagamento = getFormasPagamento();
    categoriasDespesas = dadosForm['categoriasDespesas'];
    cartoesCredito = dadosForm['cartoesCredito'];
    cartoesDebito = dadosForm['cartoesDebito'];
    despesa = dadosForm['despesa'];

    if (despesa != null) {
      titulo = TextEditingController(text: despesa!.titulo);
      valor = TextEditingController(text: despesa!.valor.toString());
      data = TextEditingController(
          text: DateFormat('dd/MM/yyyy')
              .format(DateTime.fromMillisecondsSinceEpoch(
        despesa!.data.millisecondsSinceEpoch,
      )));
      categoriasDespesasValue = despesa!.categoria;
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
