import 'package:flutter/material.dart';

class CadastroWidgetController {
  final formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  TextEditingController confirmarSenha = TextEditingController();
  TextEditingController nome = TextEditingController();
  TextEditingController sobrenome = TextEditingController();

  CadastroWidgetController();
}
