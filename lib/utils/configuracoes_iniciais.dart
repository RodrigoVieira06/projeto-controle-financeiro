class ConfiguracoesIniciais {
  ConfiguracoesIniciais();

  final List<Map<String, dynamic>> categoriasDespesas = [
    {
      'titulo': 'Moradia',
      'descricao':
          'Despesas destinadas à casa, como: Conta de luz, internet, etc.',
      'bloqueado': true,
      'valorTotal': 0
    },
    {
      'titulo': 'Lazer',
      'descricao': 'Despesas destinadas ao lazer e entretenimento.',
      'bloqueado': true,
      'valorTotal': 0
    },
    {
      'titulo': 'Mercado',
      'descricao': 'Despesas destinadas às compras mensais em mercados.',
      'bloqueado': true,
      'valorTotal': 0
    },
    {
      'titulo': 'Transporte',
      'descricao': 'Despesas destinadas ao deslocamento.',
      'bloqueado': true,
      'valorTotal': 0
    },
    {
      'titulo': 'Estética',
      'descricao':
          'Despesas destinadas à aparência, como: cortar o cabelo, academia, etc.',
      'bloqueado': true,
      'valorTotal': 0
    },
    {
      'titulo': 'Saúde',
      'descricao':
          'Despesas destinadas à saúde, como: medicamentos, vitaminas, etc.',
      'bloqueado': true,
      'valorTotal': 0
    },
    {
      'titulo': 'Seguros',
      'descricao': 'Despesas destinadas à seguros.',
      'bloqueado': true,
      'valorTotal': 0
    },
    {
      'titulo': 'Alimentação',
      'descricao': 'Despesas destinadas à alimentação.',
      'bloqueado': true,
      'valorTotal': 0
    },
    {
      'titulo': 'Educação',
      'descricao': 'Despesas destinadas à educação, como ',
      'bloqueado': true,
      'valorTotal': 0
    }
  ];

  final List<Map<String, dynamic>> categoriasFaturamentos = [
    {
      'titulo': 'Salário',
      'descricao': 'Faturamentos com salário.',
      'bloqueado': true,
      'valorTotal': 0,
    }
  ];
}
