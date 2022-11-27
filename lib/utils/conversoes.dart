class Conversoes {
  Conversoes();

  String convertMonth(num month) {
    switch (month) {
      case 1:
        return 'JANEIRO';
      case 2:
        return 'FEVEREIRO';
      case 3:
        return 'MARÇO';
      case 4:
        return 'ABRIL';
      case 5:
        return 'MAIO';
      case 6:
        return 'JUNHO';
      case 7:
        return 'JULHO';
      case 8:
        return 'AGOSTO';
      case 9:
        return 'SETEMBRO';
      case 10:
        return 'OUTUBRO';
      case 11:
        return 'NOVEMBRO';
      case 12:
        return 'DEZEMBRO';
    }
    throw 'Mês não encontrado.';
  }
}
