class Despesa {
  late String titulo;
  late num valor;
  late String data;
  late String categoriaDespesa;
  late String formaPagamento;
  late String? observacoes;

  Despesa({
    required this.titulo,
    required this.valor,
    required this.data,
    required this.categoriaDespesa,
    required this.formaPagamento,
    this.observacoes,
  });

  factory Despesa.fromJson(Map<String, dynamic> json) {
    return Despesa(
      titulo: json['titulo'],
      valor: json['valor'],
      data: json['data'],
      categoriaDespesa: json['categoriaDespesa'],
      formaPagamento: json['formaPagamento'],
      observacoes: json['observacoes'],
    );
  }
}
