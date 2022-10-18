class DespesasModel {
  late String titulo;
  late num valor;
  late String data;
  late String categoriaDespesa;
  late String formaPagamento;
  late String? observacoes;

  DespesasModel({
    required this.titulo,
    required this.valor,
    required this.data,
    required this.categoriaDespesa,
    required this.formaPagamento,
    this.observacoes,
  });

  factory DespesasModel.fromJson(Map<String, dynamic> json) {
    return DespesasModel(
      titulo: json['titulo'],
      valor: json['valor'],
      data: json['data'],
      categoriaDespesa: json['categoriaDespesa'],
      formaPagamento: json['formaPagamento'],
      observacoes: json['observacoes'],
    );
  }
}
