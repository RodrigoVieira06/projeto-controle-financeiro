import 'package:cloud_firestore/cloud_firestore.dart';

class Faturamento {
  late String titulo;
  late num valor;
  late Timestamp data;
  late String categoriaFaturamento;
  late String? observacoes;

  Faturamento({
    required this.titulo,
    required this.valor,
    required this.data,
    required this.categoriaFaturamento,
    this.observacoes,
  });

  factory Faturamento.fromJson(Map<String, dynamic> json) {
    return Faturamento(
      titulo: json['titulo'],
      valor: json['valor'],
      data: json['data'],
      categoriaFaturamento: json['categoriaFaturamento'],
      observacoes: json['observacoes'],
    );
  }
}
