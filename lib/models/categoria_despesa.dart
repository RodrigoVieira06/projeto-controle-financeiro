class CategoriaDespesa {
  late String titulo;
  late String? descricao;

  CategoriaDespesa({
    required this.titulo,
    this.descricao,
  });

  factory CategoriaDespesa.fromJson(Map<String, dynamic> json) {
    return CategoriaDespesa(
      titulo: json['titulo'],
      descricao: json['descricao'],
    );
  }
}
