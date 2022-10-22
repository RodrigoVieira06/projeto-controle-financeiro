class CartaoDebito {
  late String titulo;
  late String? descricao;

  CartaoDebito({
    required this.titulo,
    this.descricao,
  });

  factory CartaoDebito.fromJson(Map<String, dynamic> json) {
    return CartaoDebito(
      titulo: json['titulo'],
      descricao: json['descricao'],
    );
  }
}
