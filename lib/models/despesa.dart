import 'package:cloud_firestore/cloud_firestore.dart';

class Despesa {
  late String titulo;
  late num valor;
  late Timestamp data;
  late String categoria;
  late String formaPagamento;
  late String? cartao;
  late String? observacoes;
  late String? uid;

  Despesa({
    required this.titulo,
    required this.valor,
    required this.data,
    required this.categoria,
    required this.formaPagamento,
    this.cartao,
    this.observacoes,
    this.uid,
  });

  factory Despesa.fromJson(Map<String, dynamic> json) {
    return Despesa(
      titulo: json['titulo'],
      valor: json['valor'],
      data: json['data'],
      categoria: json['categoria'],
      formaPagamento: json['formaPagamento'],
      cartao: json['cartao'],
      observacoes: json['observacoes'],
      uid: json['uid'],
    );
  }
}
