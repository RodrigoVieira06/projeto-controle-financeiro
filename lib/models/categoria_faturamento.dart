class CategoriaFaturamento {
  late String titulo;
  late String? descricao;

  CategoriaFaturamento({
    required this.titulo,
    this.descricao,
  });

  factory CategoriaFaturamento.fromJson(Map<String, dynamic> json) {
    return CategoriaFaturamento(
      titulo: json['titulo'],
      descricao: json['descricao'],
    );
  }
}
