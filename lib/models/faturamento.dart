import 'package:cloud_firestore/cloud_firestore.dart';

class Faturamento {
  late String titulo;
  late num valor;
  late Timestamp data;
  late String categoria;
  late String? observacoes;
  late String? uid;

  Faturamento({
    required this.titulo,
    required this.valor,
    required this.data,
    required this.categoria,
    this.observacoes,
    this.uid,
  });

  factory Faturamento.fromJson(Map<String, dynamic> json) {
    return Faturamento(
      titulo: json['titulo'],
      valor: json['valor'],
      data: json['data'],
      categoria: json['categoria'],
      observacoes: json['observacoes'],
      uid: json['uid'],
    );
  }
}
