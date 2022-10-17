import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_controle_financeiro/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:projeto_controle_financeiro/services/services.dart';
import 'package:projeto_controle_financeiro/components/loading_widget.dart';
import 'package:projeto_controle_financeiro/screens/home/page/home_page_widget.dart';
import 'package:projeto_controle_financeiro/screens/login/page/login_page.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    if (auth.isLoading) {
      return Scaffold(
        backgroundColor: projectTheme.backgroundColor,
        body: const LoadingWidget(),
      );
    }
    if (auth.usuario == null) {
      Modular.to.navigate('/');
      return const LoginPage();
    } else {
      Modular.to.navigate('/home/');
      return const HomePageWidget();
    }
  }
}
