import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Masks {
  Masks();

  final dateMask = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final moneyMask = MaskTextInputFormatter(
    mask: 'R\$ #,##',
    filter: {"#": RegExp(r'[0-9]')},
  );
}
