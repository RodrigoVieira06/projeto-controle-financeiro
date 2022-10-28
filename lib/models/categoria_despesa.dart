class CategoriaDespesa {
  late String titulo;
  late num? id;
  late String? descricao;
  late bool? bloqueado;

  CategoriaDespesa({
    required this.titulo,
    this.id,
    this.descricao,
    this.bloqueado,
  });

  factory CategoriaDespesa.fromJson(Map<String, dynamic> json) {
    return CategoriaDespesa(
      titulo: json['titulo'],
      id: json['id'],
      descricao: json['descricao'],
      bloqueado: json['bloqueado'],
    );
  }
}
