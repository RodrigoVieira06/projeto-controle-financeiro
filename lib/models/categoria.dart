import 'package:cloud_firestore/cloud_firestore.dart';

class Categoria {
  late String id;
  late String titulo;
  late Timestamp data;
  late String? descricao;

  Categoria({
    required this.id,
    required this.titulo,
    required this.data,
    this.descricao,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'],
      titulo: json['titulo'],
      data: json['data'],
      descricao: json['descricao'],
    );
  }
}
