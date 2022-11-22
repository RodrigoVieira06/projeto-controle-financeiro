import 'package:cloud_firestore/cloud_firestore.dart';

class CartaoDebito {
  late String id;
  late String titulo;
  late Timestamp data;
  late String? descricao;

  CartaoDebito({
    required this.id,
    required this.titulo,
    required this.data,
    this.descricao,
  });

  factory CartaoDebito.fromJson(Map<String, dynamic> json) {
    return CartaoDebito(
      id: json['id'],
      titulo: json['titulo'],
      data: json['data'],
      descricao: json['descricao'],
    );
  }
}
