import 'package:cloud_firestore/cloud_firestore.dart';

class CartaoDebito {
  late String uid;
  late String titulo;
  late Timestamp data;
  late String? descricao;

  CartaoDebito({
    required this.uid,
    required this.titulo,
    required this.data,
    this.descricao,
  });

  factory CartaoDebito.fromJson(Map<String, dynamic> json) {
    return CartaoDebito(
      uid: json['uid'],
      titulo: json['titulo'],
      data: json['data'],
      descricao: json['descricao'],
    );
  }
}
