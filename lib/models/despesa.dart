class Despesa {
  final String titulo;
  final double valor;
  final String data;

  Despesa(
    this.titulo,
    this.valor,
    this.data,
  );

  // Despesa.fromJson(Map<String, dynamic> json)
  //     : titulo = json['titulo'],
  //       valor = json['valor'],
  //       data = json['data'];

  // Map<String, dynamic> toJson() => {
  //       'titulo': titulo,
  //       'valor': valor,
  //       'data': data,
  //     };

  // @override
  // String toString() {
  //   return 'Transaction{valor: $valor}';
  // }
}
