class CategoriaDespesa {
  late String uid;
  late String titulo;
  late num valorTotal;
  late String? descricao;
  late bool? bloqueado;

  CategoriaDespesa({
    required this.uid,
    required this.titulo,
    required this.valorTotal,
    this.descricao,
    this.bloqueado,
  });

  factory CategoriaDespesa.fromJson(Map<String, dynamic> json) {
    return CategoriaDespesa(
      uid: json['uid'],
      titulo: json['titulo'],
      valorTotal: json['valorTotal'],
      descricao: json['descricao'],
      bloqueado: json['bloqueado'],
    );
  }
}
