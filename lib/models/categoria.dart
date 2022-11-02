import 'package:cloud_firestore/cloud_firestore.dart';

class Categoria {
  late String uid;
  late String titulo;
  late Timestamp data;
  late bool bloqueado;
  late num valorTotal;
  late String? descricao;

  Categoria({
    required this.uid,
    required this.titulo,
    required this.data,
    required this.bloqueado,
    required this.valorTotal,
    this.descricao,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      uid: json['uid'],
      titulo: json['titulo'],
      data: json['data'],
      bloqueado: json['bloqueado'],
      valorTotal: json['valorTotal'],
      descricao: json['descricao'],
    );
  }
}
