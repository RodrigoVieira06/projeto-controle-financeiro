import 'package:cloud_firestore/cloud_firestore.dart';

class ConfiguracoesIniciais {
  ConfiguracoesIniciais();

  final List<Map<String, dynamic>> categoriasDespesas = [
    {
      'titulo': 'Moradia',
      'descricao':
          'Despesas destinadas à casa, como: Conta de luz, internet, etc.',
      'bloqueado': true,
      'data': Timestamp.now(),
      'valorTotal': 0,
    },
    {
      'titulo': 'Lazer',
      'descricao': 'Despesas destinadas ao lazer e entretenimento.',
      'bloqueado': true,
      'data': Timestamp.now(),
      'valorTotal': 0,
    },
    {
      'titulo': 'Mercado',
      'descricao': 'Despesas destinadas às compras mensais em mercados.',
      'bloqueado': true,
      'data': Timestamp.now(),
      'valorTotal': 0,
    },
    {
      'titulo': 'Transporte',
      'descricao': 'Despesas destinadas ao deslocamento.',
      'bloqueado': true,
      'data': Timestamp.now(),
      'valorTotal': 0,
    },
    {
      'titulo': 'Estética',
      'descricao':
          'Despesas destinadas à aparência, como: cortar o cabelo, academia, etc.',
      'bloqueado': true,
      'data': Timestamp.now(),
      'valorTotal': 0,
    },
    {
      'titulo': 'Saúde',
      'descricao':
          'Despesas destinadas à saúde, como: medicamentos, vitaminas, etc.',
      'bloqueado': true,
      'data': Timestamp.now(),
      'valorTotal': 0,
    },
    {
      'titulo': 'Seguros',
      'descricao': 'Despesas destinadas à seguros.',
      'bloqueado': true,
      'data': Timestamp.now(),
      'valorTotal': 0,
    },
    {
      'titulo': 'Alimentação',
      'descricao': 'Despesas destinadas à alimentação.',
      'bloqueado': true,
      'data': Timestamp.now(),
      'valorTotal': 0,
    },
    {
      'titulo': 'Educação',
      'descricao': 'Despesas destinadas à educação, como ',
      'bloqueado': true,
      'data': Timestamp.now(),
      'valorTotal': 0,
    }
  ];

  final List<Map<String, dynamic>> categoriasFaturamentos = [
    {
      'titulo': 'Salário',
      'descricao': 'Faturamentos com salário.',
      'bloqueado': true,
      'data': Timestamp.now(),
      'valorTotal': 0,
    }
  ];
}
