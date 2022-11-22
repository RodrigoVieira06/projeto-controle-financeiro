import 'package:cloud_firestore/cloud_firestore.dart';

class CartaoCredito {
  late String id;
  late String titulo;
  late int diaVencimento;
  late Timestamp data;
  late String? descricao;

  CartaoCredito({
    required this.id,
    required this.titulo,
    required this.diaVencimento,
    required this.data,
    this.descricao,
  });

  factory CartaoCredito.fromJson(Map<String, dynamic> json) {
    return CartaoCredito(
      id: json['id'],
      titulo: json['titulo'],
      diaVencimento: json['diaVencimento'],
      data: json['data'],
      descricao: json['descricao'],
    );
  }
}
