import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Masks {
  Masks();

  final dateMask = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final diaVencimento = MaskTextInputFormatter(
    mask: '##',
    filter: {"#": RegExp(r'[0-9]')},
  );
}
