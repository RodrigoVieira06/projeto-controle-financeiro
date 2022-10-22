class CartaoCredito {
  late String titulo;
  late String? descricao;

  CartaoCredito({
    required this.titulo,
    this.descricao,
  });

  factory CartaoCredito.fromJson(Map<String, dynamic> json) {
    return CartaoCredito(
      titulo: json['titulo'],
      descricao: json['descricao'],
    );
  }
}
