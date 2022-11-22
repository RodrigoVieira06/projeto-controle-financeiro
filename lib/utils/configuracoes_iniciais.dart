import 'package:cloud_firestore/cloud_firestore.dart';

class ConfiguracoesIniciais {
  ConfiguracoesIniciais();

  final List<Map<String, dynamic>> categoriasDespesas = [
    {
      'titulo': 'Moradia',
      'descricao':
          'Despesas destinadas à casa, como: Conta de luz, internet, etc.',
      'data': Timestamp.now(),
    },
    {
      'titulo': 'Lazer',
      'descricao': 'Despesas destinadas ao lazer e entretenimento.',
      'data': Timestamp.now(),
    },
    {
      'titulo': 'Mercado',
      'descricao': 'Despesas destinadas às compras mensais em mercados.',
      'data': Timestamp.now(),
    },
    {
      'titulo': 'Transporte',
      'descricao': 'Despesas destinadas ao deslocamento.',
      'data': Timestamp.now(),
    },
    {
      'titulo': 'Estética',
      'descricao':
          'Despesas destinadas à aparência, como: cortar o cabelo, academia, etc.',
      'data': Timestamp.now(),
    },
    {
      'titulo': 'Saúde',
      'descricao':
          'Despesas destinadas à saúde, como: medicamentos, vitaminas, etc.',
      'data': Timestamp.now(),
    },
    {
      'titulo': 'Seguros',
      'descricao': 'Despesas destinadas à seguros.',
      'data': Timestamp.now(),
    },
    {
      'titulo': 'Alimentação',
      'descricao': 'Despesas destinadas à alimentação.',
      'data': Timestamp.now(),
    },
    {
      'titulo': 'Educação',
      'descricao': 'Despesas destinadas à educação, como ',
      'data': Timestamp.now(),
    }
  ];

  final List<Map<String, dynamic>> categoriasFaturamentos = [
    {
      'titulo': 'Salário',
      'descricao': 'Faturamentos com salário.',
      'data': Timestamp.now(),
    }
  ];
}
