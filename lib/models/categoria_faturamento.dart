class CategoriaFaturamento {
  late String uid;
  late String titulo;
  late num valorTotal;
  late String? descricao;

  CategoriaFaturamento({
    required this.uid,
    required this.titulo,
    required this.valorTotal,
    this.descricao,
  });

  factory CategoriaFaturamento.fromJson(Map<String, dynamic> json) {
    return CategoriaFaturamento(
      uid: json['uid'],
      titulo: json['titulo'],
      valorTotal: json['valorTotal'],
      descricao: json['descricao'],
    );
  }
}
