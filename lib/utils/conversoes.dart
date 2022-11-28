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

  String convertResumedMonth(num month) {
    switch (month) {
      case 1:
        return 'jan';
      case 2:
        return 'fev';
      case 3:
        return 'mar';
      case 4:
        return 'abr';
      case 5:
        return 'mai';
      case 6:
        return 'jun';
      case 7:
        return 'jul';
      case 8:
        return 'ago';
      case 9:
        return 'set';
      case 10:
        return 'out';
      case 11:
        return 'nov';
      case 12:
        return 'dez';
    }
    throw 'Mês não encontrado.';
  }
}
