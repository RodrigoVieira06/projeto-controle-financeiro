import 'package:cloud_firestore/cloud_firestore.dart';

class CartaoDebito {
  late String uid;
  late String titulo;
  late Timestamp data;
  late bool bloqueado;
  late String? descricao;

  CartaoDebito({
    required this.uid,
    required this.titulo,
    required this.data,
    required this.bloqueado,
    this.descricao,
  });

  factory CartaoDebito.fromJson(Map<String, dynamic> json) {
    return CartaoDebito(
      uid: json['uid'],
      titulo: json['titulo'],
      data: json['data'],
      bloqueado: json['bloqueado'],
      descricao: json['descricao'],
    );
  }
}
